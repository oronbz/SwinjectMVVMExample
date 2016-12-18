//
//  ResponseEntitySpec.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Quick
import Nimble
@testable import ExampleModel

class ResponseEntitySpec: QuickSpec {
    override func spec() {
        let json: [String: Any] = [
            "totalHits": 123,
            "hits": [imageJSON, imageJSON]
        ]
        
        it("parses JSON data to create a new instance") {
            let response: ResponseEntity? = try? ResponseEntity.decodeValue(json)
            
            expect(response).notTo(beNil())
            expect(response?.totalCount) == 123
            expect(response?.images.count) == 2
        }
    }
}
