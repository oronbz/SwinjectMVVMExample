//
//  ImageSearchTableViewModelSpec.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift
@testable import ExampleViewModel
@testable import ExampleModel

class ImageSearchTableViewModelSpec: QuickSpec {
    // MARK: Stub
    class StubImageSearch: ImageSearching {
        func searchImages() -> SignalProducer<ResponseEntity, NetworkError> {
            return SignalProducer { observer, disposable in
                observer.send(value: dummyResponse)
                observer.sendCompleted()
            }
            .observe(on: QueueScheduler())
        }
    }
    
    // MARK: Spec
    override func spec() {
        var viewModel: ImageSearchTableViewModel!
        beforeEach {
            viewModel = ImageSearchTableViewModel(imageSearch: StubImageSearch())
        }
        
        it("eventually sets cellModels property after the search") {
            var cellModels: [ImageSearchTableViewCellModeling]? = nil
            viewModel.cellModels.producer
                .on(value: {
                    cellModels = $0
                })
                .start()
            viewModel.startSearch()
            
            expect(cellModels).toNotEventually(beNil())
            expect(cellModels?.count).toEventually(equal(2))
            expect(cellModels?[0].id).toEventually(equal(10000))
            expect(cellModels?[1].id).toEventually(equal(10001))
        }
        
        it("sets cellModels property on the main thread") {
            var onMainThread = false
            viewModel.cellModels.producer
                .on(value: { _ in onMainThread = Thread.isMainThread })
                .start()
            viewModel.startSearch()
            
            expect(onMainThread).toEventually(beTrue())
        }
    }
}
