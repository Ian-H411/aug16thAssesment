//
//  MovieController.swift
//  aug16thAssesment
//
//  Created by Ian Hall on 8/16/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//


// 5th is a query component of api_key set equal to my key bbebd8d1bb4e5823b7aa133f811b3e32

//  finishing up with a query of key: query value: search term


import Foundation
import UIKit.UIImage

class MovieController{
    
    //this will get the movies
    static func fetchMovies (searchTerm: String, completion: @escaping ([MovieJson]) -> Void) {
        
        //base url
        var componentURL = URLComponents(string: "https://api.themoviedb.org/3/search/movie")
        
        //now for a list of query items for the search term and my key
        let urlQueryItems = [URLQueryItem(name: "api_key", value: "bbebd8d1bb4e5823b7aa133f811b3e32"), URLQueryItem(name: "query", value: searchTerm)]
        
        //set my components to the prviously made query items
        componentURL?.queryItems = urlQueryItems
        
        //guard let to a final URL
        guard let finalURL = componentURL?.url else {completion([]); return}
        
        //TODO: - TEST URL - works perfect 10/10

        //create the session
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            //check if we had an error
            if let error = error {completion([]); print("error in url dataTask check url \n -----\n" + error.localizedDescription) ;return}
            
            guard let data = data else {completion([]); return}
            do{
                //grab the decoder and decode
                let deocder = JSONDecoder()
                let movieHeadJson = try deocder.decode(MovieHeadJson.self, from: data)
                
                //convert to a list of jsonmovies
                let movieListJson = movieHeadJson.results
                
                print(movieListJson)
                completion(movieListJson)
                return
                
            } catch {
                print(error.localizedDescription)
                print(error)
                completion ([])
                return
            }
            
            }.resume()
        
        
    }
    
    //call in previous func if there is a poster id
    static func fetchMoviePoster (extensionPath: String, completion: @escaping (UIImage?) -> Void){
        // base URL
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500/") else {completion(nil); return}
        //add extension given
        let finalURL = baseURL.appendingPathComponent(extensionPath)
        //create a session
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                //this completion will be within a for loop gotta be real on top of errors
                print("error with creating a data task check URL")
                print(error.localizedDescription)
                print(error)
                completion(nil)
                return
            }
            //grab the data
            guard let data = data else {completion(nil); return}
            
            //make it a pretty picture
            guard let poster = UIImage(data: data) else {completion(nil); return}
            completion(poster)
            return
            
            }.resume()
        
    }
}
