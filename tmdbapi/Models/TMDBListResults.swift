//
//  TMDBListResults.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/25/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol TMDBListResultProtocol {
    var title: String { get }
    var description: String { get }
    var imagePath: String { get }
    var mediaType: TMDBMediaType { get }
}

public class TMDBMovieListResult: TMDBListResultProtocol {
    public let posterPath: String?
    
    public let isAdult: Bool
    public let overview: String
    public let releaseDate: Date
    public let originalTitle: String
    public let genres: [TMDBMovieGenre]
    
    public let id: UInt
    
    public let originalLanguage: String
    public let movieTitle: String
    public let backdropPath: String
    public let popularity: NSNumber
    public let voteCount: Int
    
    public let hasVideo: Bool
    public let voteAverage: NSNumber
    
    // MARK: TMDBListResult
    public var title: String {
        get {
            return self.movieTitle
        }
    }
    public var description: String {
        get {
            return self.overview
        }
    }
    public var imagePath: String {
        get {
            return self.backdropPath
        }
    }
    public var mediaType : TMDBMediaType
    
    internal init?(json: JSON) {
        guard let mediaType = TMDBMediaType(rawValue: json["media_type"].stringValue) else {
            return nil
        }
        self.mediaType = mediaType
        
        self.posterPath = json["poster_path"].string
        self.isAdult = json["adult"].boolValue
        self.overview = json["overview"].stringValue
        self.releaseDate = TMDBAPIStatic.dateFormatter.date(from: json["release_date"].stringValue)!
        
        self.originalTitle = json["original_title"].stringValue
        self.id = json["id"].uIntValue
        self.originalLanguage = json["original_language"].stringValue
        self.movieTitle = json["title"].stringValue
        self.backdropPath = json["backdrop_path"].stringValue
        self.popularity = json["popularity"].numberValue
        self.voteCount = json["vote_count"].intValue
        
        self.hasVideo = json["video"].boolValue
        self.voteAverage = json["vote_average"].numberValue
        
        // Genres
        var genres = [TMDBMovieGenre]()
        for (_, genreID):(String, JSON) in json["genere_ids"] {
            if let genre = TMDBMovieGenre(rawValue: genreID.intValue) {
                genres.append(genre)
            }
        }
        self.genres = genres
    }
    
}

public class TMDBTVListResult: TMDBListResultProtocol {
    public let posterPath: String?
    
    public let overview: String
    public let firstAirDate: Date
    public let originalName: String
    public let genres: [TMDBTVGenre]
    public let originCountries: [String]
    
    public let id: UInt
    
    public let originalLanguage: String
    public let name: String
    public let backdropPath: String
    public let popularity: NSNumber
    public let voteCount: Int
    
    public let voteAverage: NSNumber
    
    // MARK: TMDBListResult
    public var title: String {
        get {
            return self.name
        }
    }
    public var description: String {
        get {
            return self.overview
        }
    }
    public var imagePath: String {
        get {
            return self.backdropPath
        }
    }
    public var mediaType : TMDBMediaType
    
    internal init?(json: JSON) {
        guard let mediaType = TMDBMediaType(rawValue: json["media_type"].stringValue) else {
            return nil
        }
        self.mediaType = mediaType
        
        self.posterPath = json["poster_path"].string
        self.overview = json["overview"].stringValue
        self.firstAirDate = TMDBAPIStatic.dateFormatter.date(from: json["first_air_date"].stringValue)!
        
        self.originalName = json["original_name"].stringValue
        self.id = json["id"].uIntValue
        self.originalLanguage = json["original_language"].stringValue
        self.name = json["name"].stringValue
        self.backdropPath = json["backdrop_path"].stringValue
        self.popularity = json["popularity"].numberValue
        self.voteCount = json["vote_count"].intValue
        
        self.voteAverage = json["vote_average"].numberValue
        
        // Genres
        var genres = [TMDBTVGenre]()
        for (_, genreID):(String, JSON) in json["genere_ids"] {
            if let genre = TMDBTVGenre(rawValue: genreID.intValue) {
                genres.append(genre)
            }
        }
        self.genres = genres
        
        // Origin countries
        var originCountries = [String]()
        for (_, country):(String, JSON) in json["origin_country"] {
            originCountries.append(country.stringValue)
        }
        self.originCountries = originCountries
    }
    
}

public class TMDBPersonListResult {
    
}

public enum TMDBMediaType: String {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}
