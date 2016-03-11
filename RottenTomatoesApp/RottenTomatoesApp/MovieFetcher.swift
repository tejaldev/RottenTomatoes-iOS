//
//  MovieFetcher.swift
//  RottenTomatoesApp
//
//  Created by Tejal Par on 9/15/14.
//

import Foundation

// Currently not using this class added for RnD
class MovieFetcher{
    
    func fetchMovies(callback: (Array<MovieItem>?, NSError?) -> ()) {
        self.fetchMovieItems(callback, type: nil)
    }
    
    private func fetchMovieItems(callback: (Array<MovieItem>?, NSError?) -> (), type: String?) {
        var url1 = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
        
        
        let url = NSURL(string: url1)
        let request = NSURLRequest(URL: url!)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
    }
    
    private func parseResults(responseObject: AnyObject) -> Array<MovieItem> {
        
        return Array()
    }
}