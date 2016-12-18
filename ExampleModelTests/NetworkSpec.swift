//
//  NetworkSpec.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
@testable import ExampleModel

class NetworkSpec: QuickSpec {
    override func spec() {
        var network: Network!
        beforeEach {
            network = Network()
        }
        
        describe("JSON") {
            it("eventually gets JSON data as specified with parameters") {
                var json: [String: Any]? = nil
                let url = "https://httpbin.org/get"
                network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                    .on(value: { json = $0 as? [String: Any] })
                    .start()
                
                expect(json).toEventuallyNot(beNil(), timeout: 5)
                expect((json?["args"] as? [String: Any])?["a"] as? String).toEventually(equal("b"), timeout: 5)
                expect((json?["args"] as? [String: Any])?["x"] as? String).toEventually(equal("y"), timeout: 5)
            }
            
            it("eventually gets an error if the network has a problem") {
                var error: NetworkError? = nil
                let url = "https://not.existing.server.comm/get"
                network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                    .on(failed: { error = $0 })
                    .start()
                
                expect(error).toEventually(equal(NetworkError.NotReachedServer), timeout: 5)
            }
        }
    }
}

