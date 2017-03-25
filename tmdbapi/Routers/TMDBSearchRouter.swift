//
//  TMDBSearchRouter.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

internal enum TMDBSearchRouter: URLRequestConvertible {
    case multi(query: String)
    
    static let baseURLString = TMDBAPIStatic.baseURL + "/search"
    
    var method: HTTPMethod {
        switch self {
        case .multi:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .multi(let queryString):
            return "/multi?query=\(queryString)"
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try TMDBSearchRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
