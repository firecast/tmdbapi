//
//  TMDBGenres.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation

public enum TMDBMovieGenre: Int {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    public func toString() -> String {
        switch self {
        case .tvMovie:
            return "TV Movie"
        default:
            return String(describing: self).camelCaps
        }
    }
}

public enum TMDBTVGenre: Int {
    case actionAndAdventure = 10759
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case kids = 10762
    case mystery = 9648
    case news = 10763
    case reality = 10764
    case scifiAndFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warAndPolitics = 10768
    case western = 37
    
    public func toString() -> String {
        switch self {
        case .actionAndAdventure, .warAndPolitics:
            return String(describing: self).camelCaps.replacingOccurrences(of: "And", with: "&")
        case .scifiAndFantasy:
            return "Sci-Fi & Fantasy"
        default:
            return String(describing: self).camelCaps
        }
    }
}

extension String {
    
    var camelCaps: String {
        var newString: String = ""
        
        let upperCase = CharacterSet.uppercaseLetters
        for scalar in self.unicodeScalars {
            if upperCase.contains(scalar) {
                newString.append(" ")
            }
            let character = Character(scalar)
            newString.append(character)
        }
        
        return newString.capitalized
    }
}
