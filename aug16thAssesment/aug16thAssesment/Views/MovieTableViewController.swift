//
//  MovieTableViewController.swift
//  aug16thAssesment
//
//  Created by Ian Hall on 8/16/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movieList:[Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        tableView.reloadData()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let movies = movieList else {return 0 }
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //case as movietableviewcell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        //unwrap my list
        guard let movieList = movieList else {return UITableViewCell()}
        //grab my movie
        let movie = movieList[indexPath.row]
        //send to cell
        cell.movie = movie
        cell.update()
        tableView.reloadData()
        return cell
    }
    // will search and grab poster updating the list
    func updateAndSearch(){
        guard let searchTerm = movieSearchBar.text?.lowercased() else {return}
        
        MovieController.fetchMovies(searchTerm: searchTerm) { (movies) in
            //for each of the movies we grab
            for movie in movies{
                //make sure it can convert
                guard let movieObject = Movie(movieJson: movie) else{return}
                //grab its poster
                self.movieList?.append(movieObject)
                print(movieObject)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension MovieTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text?.lowercased() else {return}
        
        MovieController.fetchMovies(searchTerm: searchTerm) { (movies) in
            //for each of the movies we grab
            var list:[Movie] = []
            for movie in movies{
                //make sure it can convert
                let movieObject = Movie(movieJson: movie)
                    //grab its poster
                guard let newmovie = movieObject else {return}
                    list.append(newmovie)
                self.movieList = list
                    print(newmovie)
                self.tableView.reloadData()
            }
        }
        if let movieList = movieList {
            print(movieList.count)
        }
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
}
