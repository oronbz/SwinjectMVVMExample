//
//  Pixabay.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/18/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

internal struct Pixabay {
    internal static let apiURL = "https://pixabay.com/api/"
    
    internal static var requestParameters: [String: Any] {
        return [
            "key": Config.apiKey,
            "image_type": "photo",
            "safesearch": true,
            "per_page": 50,
        ]
    }
}

extension Pixabay {
    fileprivate struct Config {
        static let apiKey = "4017573-b57d4cbd50129be15320be445"
    }
}
