//
//  ImageSearchTableViewCellModeling.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import Result

public protocol ImageSearchTableViewCellModeling {
    var id: UInt64 { get }
    var pageImageSizeText: String { get }
    var tagText: String { get }
    
    func getPreviewImage() -> SignalProducer<UIImage?, NoError>
}
