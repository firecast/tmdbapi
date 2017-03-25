//
//  TMDBResponseCollectionSerializer.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


protocol ResponseCollectionSerializable {
    static func collection(json: JSON) -> [Self]
}

protocol ResponseSerializable: ResponseObjectSerializable, ResponseCollectionSerializable {}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(json: JSON) -> [Self] {
        var collection: [Self] = []
        
        for (_, resultJSON):(String, JSON) in json["results"] {
            if let item = Self(json: resultJSON) {
                collection.append(item)
            }
        }
        
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(TMDBAPIError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(TMDBAPIError.jsonSerialization(error: result.error!))
            }
            
            guard let _ = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(TMDBAPIError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(json: JSON(jsonObject)))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
