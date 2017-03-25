//
//  TMDBAPIRequestAdaptar.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

internal class TMDBAPIKeyAdaptar: RequestAdapter {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    internal func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString {
            let newURL = URL(string: urlString + "&api_key=" + self.apiKey)
            urlRequest.url = newURL
        }
        
        return urlRequest
    }
}
