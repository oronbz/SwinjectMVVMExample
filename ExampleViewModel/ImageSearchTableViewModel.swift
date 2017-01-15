//
//  ImageSearchTableViewModel.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import ExampleModel

public final class ImageSearchTableViewModel: ImageSearchTableViewModeling {
    
    public var cellModels: Property<[ImageSearchTableViewCellModeling]> {
        return Property(_cellModels)
    }
    private let _cellModels = MutableProperty<[ImageSearchTableViewCellModeling]>([])
    private let imageSearch: ImageSearching
    
    public init(imageSearch: ImageSearching) {
        self.imageSearch = imageSearch
    }
    
    public func startSearch() {
        imageSearch.searchImages()
            .map { response in
                response.images.map {
                    ImageSearchTableViewCellModel(image: $0) as ImageSearchTableViewCellModeling
                }
            }
            .observe(on: UIScheduler())
            .on(value: { self._cellModels.value = $0 })
            .start()
    }
}
