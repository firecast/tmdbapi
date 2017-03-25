//
//  TMDBResponseObjectSerializer.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum TMDBAPIError: Error {
    case network(error: Error)
    case jsonSerialization(error: Error)
    case objectSerialization(reason: String)
}

public protocol ResponseObjectSerializable {
    init?(json: JSON)
}

extension DataRequest {
    func responseObject<T: ResponseObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(TMDBAPIError.network(error: error!)) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(TMDBAPIError.jsonSerialization(error: result.error!))
            }
            
            guard let _ = response, let responseObject = T(json: JSON(jsonObject)) else {
                return .failure(TMDBAPIError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
