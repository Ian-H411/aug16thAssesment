//
//  Movie.swift
//  aug16thAssesment
//
//  Created by Ian Hall on 8/16/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Movie {
    
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
    
}
extension Movie{
    init? (movieJson: MovieJson){
    
            self.popularity = movieJson.popularity
            self.voteCount = movieJson.voteCount
            self.voteAverage = movieJson.voteAverage
            self.title = movieJson.title
            self.releaseDate = movieJson.releaseDate
            self.overview = movieJson.overview
            self.posterPath = movieJson.posterPath
            
            
        }
}
