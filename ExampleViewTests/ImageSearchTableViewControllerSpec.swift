//
//  ImageSearchTableViewControllerSpec.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift
import ExampleViewModel
@testable import ExampleView

class ImageSearchTableViewControllerSpec: QuickSpec {
    // MARK: Mock
    class MockViewModel: ImageSearchTableViewModeling {
        let cellModels = Property(
            MutableProperty<[ImageSearchTableViewCellModeling]>([]))
        var startSearchCallCount = 0
        
        func startSearch() {
            startSearchCallCount += 1
        }
    }
    
    // MARK: Spec
    override func spec() {
        it("starts searching images when the view is about to appear at the first time") {
            let viewModel = MockViewModel()
            let storyboard = UIStoryboard(
                name: "Main",
                bundle: Bundle(for: ImageSearchTableViewController.self))
            let viewController = storyboard.instantiateViewController(withIdentifier: "ImageSearchTableViewController") as! ImageSearchTableViewController
            viewController.viewModel = viewModel
            
            expect(viewModel.startSearchCallCount) == 0
            viewController.viewWillAppear(true)
            expect(viewModel.startSearchCallCount) == 1
            viewController.viewWillAppear(true)
            expect(viewModel.startSearchCallCount) == 1
        }
    }
}
