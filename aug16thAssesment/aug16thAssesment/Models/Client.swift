//
//  Client.swift
//  aug16thAssesment
//
//  Created by Ian Hall on 8/16/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

struct MovieHeadJson: Codable {
    let results: [MovieJson]
}

struct MovieJson: Codable {
    
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey{
        
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
    }
}
