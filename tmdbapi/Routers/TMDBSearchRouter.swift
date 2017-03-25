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
    case movie(query: String)
    case tv(query: String)
    case person(query: String)
    
    static let baseURLString = TMDBAPIStatic.baseURL + "/search"
    
    var method: HTTPMethod {
        switch self {
        case .multi:
            return .get
        case .movie:
            return .get
        case .tv:
            return .get
        case .person:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .multi(let queryString):
            return "/multi?query=\(queryString)"
        case .movie(let queryString):
            return "/movie?query=\(queryString)"
        case .tv(let queryString):
            return "/movie?query=\(queryString)"
        case .person(let queryString):
            return "/movie?query=\(queryString)"
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
