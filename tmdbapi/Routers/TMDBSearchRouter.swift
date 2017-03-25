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
        case .multi:
            return "/multi"
        case .movie:
            return "/movie"
        case .tv:
            return "/tv"
        case .person:
            return "/person"
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try TMDBSearchRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .multi(let query), .movie(let query), .person(let query), .tv(let query):
            let params = ["query": query]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }
    
}
