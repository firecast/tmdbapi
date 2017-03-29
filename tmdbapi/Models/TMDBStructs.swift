//
//  TMDBStructs.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/29/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation

public struct TMDBProductionCompany {
    let id: Int
    let name: String
}

public struct TMDBProductionCountry {
    let iso_3166_1: String
    let name: String
}

public struct TMDBSpokenLanguage {
    let iso_639_1: String
    let name: String
}
