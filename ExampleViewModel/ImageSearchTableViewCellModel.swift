//
//  ImageSearchTableViewCellModel.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import Result
import ExampleModel

public final class ImageSearchTableViewCellModel: NSObject, ImageSearchTableViewCellModeling {
    public let id: UInt64
    public let pageImageSizeText: String
    public let tagText: String
    
    private let network: Networking
    private let previewURL: String
    private var previewImage: UIImage?
    
    internal init(image: ImageEntity, network: Networking) {
        id = image.id
        pageImageSizeText = "\(image.pageImageWidth) x \(image.pageImageHeight)"
        tagText = image.tags.joined(separator: ", ")
        
        self.network = network
        previewURL = image.previewURL
        super.init()
    }
    
    public func getPreviewImage() -> SignalProducer<UIImage?, NoError> {
        if let previewImage = self.previewImage {
            return SignalProducer(value: previewImage).observe(on: UIScheduler())
        } else {
            let imageProducer = network.requestImage(url: previewURL)
                .take(until: self.reactive.lifetime.ended)
                .on(value: { self.previewImage = $0 })
                .map { $0 as UIImage? }
                .flatMapError { _ in SignalProducer<UIImage?, NoError>(value: nil) }
            
            return SignalProducer(value: nil)
                .concat(imageProducer)
                .observe(on: UIScheduler())
        }
    }
}
