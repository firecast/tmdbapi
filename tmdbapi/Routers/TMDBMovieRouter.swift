//
//  TMDBMovieRouter.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/26/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

public enum TMDBMovieRouter: URLRequestConvertible {
    case details(movieId: Int)
    case alternativeTitles(movieId: Int)
    case credits(movieId: Int)
    case images(movieId: Int)
    case releaseDates(movieId: Int)
    case videos(movieId: Int)
    case recommendations(movieId: Int, page: Int?)
    case similar(movieId: Int, page: Int?)
    case nowPlaying(page: Int?)
    case popular(page: Int?)
    case topRated(page: Int?)
    case upcoming(page: Int?)
    
    static let baseURLString = TMDBAPIStatic.baseURL + "/movie"
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .details(let movieId):
            return "/\(movieId)"
        case .alternativeTitles(let movieId):
            return "/\(movieId)/alternative_titles"
        case .credits(let movieId):
            return "/\(movieId)/credits"
        case .images(let movieId):
            return "/\(movieId)/images"
        case .releaseDates(let movieId):
            return "/\(movieId)/release_dates"
        case .videos(let movieId):
            return "/\(movieId)/videos"
        case .recommendations(let movieId, _):
            return "/\(movieId)/recommendations"
        case .similar(let movieId, _):
            return "/\(movieId)/recommendations"
        case .nowPlaying, .popular, .topRated, .upcoming:
            return ""
            
        }
    }
    
    // MARK: URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try TMDBSearchRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .recommendations(_, let page), .similar(_, let page), .nowPlaying(let page), .popular(let page), .topRated(let page), .upcoming(let page):
            let params = ["page": (page != nil) ? "\(page!)" : "1"]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            
        default:
            break
        }
        
        return urlRequest
    }
    
}
