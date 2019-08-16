//
//  MovieTableViewCell.swift
//  aug16thAssesment
//
//  Created by Ian Hall on 8/16/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    //MARK: - outlets
    var movie:Movie? {
        didSet{
            
            update()
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var moviedescriptionLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func update(){
        guard let movie = movie else {return}
        print(movie)
        MovieController.fetchMoviePoster(extensionPath: movie.posterPath) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.posterImageView.image = image
                print(movie)
                self.moviedescriptionLabel.text = movie.overview
                self.ratingLabel.text = String(movie.voteAverage)
                self.titleLabel.text = movie.title
            }
        }
    }
    
}
