//
//  ImageSearchTableViewModeling.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift

public protocol ImageSearchTableViewModeling {
    var cellModels: Property<[ImageSearchTableViewCellModeling]> { get }
    func startSearch()
}
