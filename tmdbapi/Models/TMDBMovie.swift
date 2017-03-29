//
//  TMDBMovie.swift
//  tmdbapi
//
//  Created by Amit Prabhu on 3/26/17.
//  Copyright © 2017 Amit Prabhu. All rights reserved.
//

import Foundation
import SwiftyJSON

final public class TMDBMovie: ResponseSerializable {
    
    let isAdult: Bool
    let backdropPath: String?
    
    let budget: Int?
    let genres: [TMDBMovieGenre]
    let homePage: String?
    
    let id: UInt
    let imdbId: String?
    
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    
    let popularity: NSNumber?
    let posterPath: String?
    
    let productionCompanies: [TMDBProductionCompany]?
    let productionCountries: [TMDBProductionCountry]?
    
    let releaseDate: Date?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [TMDBSpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: String?
    
    let voteAverage: NSNumber?
    let voteCount: Int?
    
    public init?(json: JSON) {
        guard let id = json["id"].uInt else {
            return nil
        }
        self.id = id
        
        self.isAdult = json["adult"].bool ?? false
        self.backdropPath = json["backdrop_path"].string
        self.budget = json["budget"].int
        
        // Genres
        var genres = [TMDBMovieGenre]()
        for (_, genreJSON): (String, JSON) in json["genres"]{
            if let genre = TMDBMovieGenre(rawValue: genreJSON["id"].intValue) {
                genres.append(genre)
            }
        }
        self.genres = genres
        self.homePage = json["homepage"].string
        self.imdbId = json["imdb_id"].string
        self.originalLanguage = json["original_language"].string
        self.originalTitle = json["original_title"].string
        self.overview = json["overview"].string
        
        self.popularity = json["popularity"].number
        self.posterPath = json["poster_path"].string
        
        // Production Companies
        var productionCompanies = [TMDBProductionCompany]()
        for (_, productionCompanyJSON):(String, JSON) in json["production_companies"] {
            if let id = productionCompanyJSON["id"].int,
                let name = productionCompanyJSON["name"].string {
                productionCompanies.append(TMDBProductionCompany(id: id, name: name))
            }
        }
        self.productionCompanies = productionCompanies
        
        // Production Countries
        var productionCountries = [TMDBProductionCountry]()
        for (_, productionCountryJSON):(String, JSON) in json["production_countries"] {
            if let iso_3166_1 = productionCountryJSON["iso_3166_1"].string,
                let name = productionCountryJSON["name"].string {
                productionCountries.append(TMDBProductionCountry(iso_3166_1: iso_3166_1, name: name))
            }
        }
        self.productionCountries = productionCountries
        
        self.releaseDate = TMDBAPIStatic.dateFormatter.date(from: json["release_date"].string ?? "")
        self.revenue = json["revenue"].int
        self.runtime = json["runtine"].int
        
        // Spoken languages
        var spokenLanguages = [TMDBSpokenLanguage]()
        for (_, spokenLanguageJSON):(String, JSON) in json["spoken_languages"] {
            if let iso_639_1 = spokenLanguageJSON["iso_639_1"].string,
                let name = spokenLanguageJSON["name"].string {
                spokenLanguages.append(TMDBSpokenLanguage(iso_639_1: iso_639_1, name: name))
            }
        }
        self.spokenLanguages = spokenLanguages
        
        self.status = json["status"].string
        self.tagline = json["tagline"].string
        self.title = json["title"].string
        self.video = json["video"].string
        
        self.voteAverage = json["vote_average"].number
        self.voteCount = json["vote_count"].int
        
    }
  
}
