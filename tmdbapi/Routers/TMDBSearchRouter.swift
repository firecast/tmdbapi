//
//  TMDBSearchRouter.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

public enum TMDBSearchRouter: URLRequestConvertible {
    case multi(query: String, page: Int?)
    case movie(query: String, page: Int?)
    case tv(query: String, page: Int?)
    case person(query: String, page: Int?)
    
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
    public func asURLRequest() throws -> URLRequest {
        let url = try TMDBSearchRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .multi(let query, let page), .movie(let query, let page), .person(let query, let page), .tv(let query, let page):
            let params = ["query": query, "page": (page != nil) ? "\(page!)" : "1"]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }
    
}
