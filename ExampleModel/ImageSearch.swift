//
//  ImageSearch.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import Result
import Himotoki

public final class ImageSearch: ImageSearching {
    private let network: Networking
    
    public init(network: Networking) {
        self.network = network
    }
    
    public func searchImages() -> SignalProducer<ResponseEntity, NetworkError> {
        let url = Pixabay.apiURL
        let parameters = Pixabay.requestParameters
        return network.requestJSON(url: url, parameters: parameters)
            .attemptMap { json in
                if let response = try? ResponseEntity.decodeValue(json) {
                    return Result(value: response)
                } else {
                    return Result(error: NetworkError.IncorrectDataReturned)
                }
            }
    }
    
    
    func eacher(num: Int) -> Void {
        print(num)
    }
}
