//
//  AppDelegateSpec.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
import Swinject
import SwinjectStoryboard
import ExampleModel
import ExampleViewModel
import ExampleView
@testable import SwinjectMVVMExample

class AppDelegateSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = AppDelegate().container
        }
        
        describe("container") {
            it("resolves every service type") {
                // Models
                expect(container.resolve(Networking.self)).notTo(beNil())
                expect(container.resolve(ImageSearching.self)).notTo(beNil())
                
                // View Models
                expect(container.resolve(ImageSearchTableViewModeling.self)).notTo(beNil())
            }
            
            it("injects view models to views") {
                let bundle = Bundle(for: ImageSearchTableViewController.self)
                let storyboard = SwinjectStoryboard.create(
                    name: "Main",
                    bundle: bundle,
                    container: container)
                let imageSearchTableViewController = storyboard.instantiateViewController(withIdentifier: "ImageSearchTableViewController") as! ImageSearchTableViewController
                
                expect(imageSearchTableViewController.viewModel).notTo(beNil())
            }
        }
    }
}
