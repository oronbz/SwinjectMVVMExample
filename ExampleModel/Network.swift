//
//  Network.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import Alamofire

public final class Network: Networking {
    private let queue = DispatchQueue(label: "SwinjectMMVMExample.ExampleModel.Network.Queue")
    
    public init() {}
    
    public func requestJSON(url: String, parameters: [String : Any]?) -> SignalProducer<Any, NetworkError> {
        return SignalProducer { observer, disposable in
            let serializer = Alamofire.DataRequest.jsonResponseSerializer()
            Alamofire.request(url, method: .get, parameters: parameters)
                .response(queue: self.queue, responseSerializer: serializer) {
                    response in
                    switch response.result {
                    case .success(let value):
                        observer.send(value: value)
                        observer.sendCompleted()
                    case .failure(let error):
                        observer.send(error: NetworkError(error: error))
                    }
            }
        }
    }
    
}
