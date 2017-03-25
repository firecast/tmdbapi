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

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseObjectSerializable>(
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
            
            var collection: [T] = []
            
            for (_, resultJSON):(String, JSON) in JSON(jsonObject)["results"] {
                if let item = T(json: resultJSON) {
                    collection.append(item)
                }
            }
            return .success(collection)
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
