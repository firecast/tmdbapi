//
//  Alamofire+Next.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

enum PaginationError: Error {
    case notSupported
}

internal extension URL {
    internal func paramValue(forParam param: String) -> String? {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        
        return urlComponents.queryItems?.first(where: { $0.name == param })?.value
    }
}

public extension Alamofire.DataRequest {
    public func nextPage(sessionManager: SessionManager) throws -> Alamofire.DataRequest {
        guard let request = self.request,
            let url = request.url,
                let currentPageString = url.paramValue(forParam: "page"),
                    let currentPage = Int(currentPageString) else {
            throw PaginationError.notSupported
        }
        
        let nextPage = currentPage + 1
        let nextPageURL = URL(string: url.absoluteString.replacingOccurrences(of: "page=\(currentPage)", with: "page=\(nextPage)"))!
        
        var newRequest = request
        newRequest.url = nextPageURL
        
        return sessionManager.request(nextPageURL, method: HTTPMethod(rawValue: request.httpMethod!)!)
        
    }
}
