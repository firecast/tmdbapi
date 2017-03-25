//
//  TMDBAPI.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import Alamofire

public class TMDBAPI {
    
    // Private variables
    private let apiKey : String
    private let requestAdaptar: TMDBAPIKeyAdaptar
    
    // Public vars
    public let sessionManager: SessionManager
    
    init(apiKey: String) {
        self.apiKey = apiKey
        
        self.requestAdaptar = TMDBAPIKeyAdaptar(apiKey: apiKey)
        self.sessionManager = SessionManager()
        self.sessionManager.adapter = self.requestAdaptar
    }
}
