//
//  Networking.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift

public protocol Networking {
    func requestJSON(url: String, parameters: [String: Any]?)
        -> SignalProducer<Any, NetworkError>
}
