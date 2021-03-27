//
//  DefaultsStorage.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/13/21.
//

import Foundation

class DefaultsStorage {
    
    static func store(key: String, movie: MovieTV) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movie) {
            defaults.set(encoded, forKey: key)
            var moviesList = getMoviesList()
            moviesList.append(movie);
            let moviesListJson = try? encoder.encode(moviesList)
            defaults.set(moviesListJson!, forKey: "movies")
        }
    }
    
    static func swap(from: NSInteger, to: NSInteger) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        var moviesList = getMoviesList()
        let temp = moviesList[from]
        moviesList[from] = moviesList[to]
        moviesList[to] = temp
        let moviesListJson = try? encoder.encode(moviesList)
        defaults.set(moviesListJson!, forKey: "movies")
    }
    
    static func getMoviesList() -> [MovieTV] {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if ((defaults.object(forKey: "movies") as? Data) != nil) {
            let moviesListJson = defaults.object(forKey: "movies") as! Data
            let moviesList = try? decoder.decode([MovieTV].self, from: moviesListJson)
            if(moviesList == nil) {
                return [MovieTV]()
            } else {
                return moviesList!
            }
        } else {
            return [MovieTV]()
        }
    }
    
    static func get(key: String) -> MovieTV? {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if((defaults.object(forKey: key) as? Data) != nil) {
            let movieJson = defaults.object(forKey: String(key)) as! Data
            if let movie = try? decoder.decode(MovieTV.self, from: movieJson) {
                return movie
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func remove(key: String) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        defaults.removeObject(forKey: key)
        var moviesList = getMoviesList()
        var removeIndex = -1
        if(moviesList.count > 0) {
            for index in 0...moviesList.count - 1 {
                if(moviesList[index].movieID == key) {
                    removeIndex = index
                }
            }
            if removeIndex != -1 {
                moviesList.remove(at: removeIndex)
            }
        }
        let moviesListJson = try? encoder.encode(moviesList)
        defaults.set(moviesListJson!, forKey: "movies")
    }
    
    static func clearAllMovies() {
        let moviesList = getMoviesList()
        if(moviesList.count > 0) {
            for index in 0...moviesList.count - 1 {
                remove(key: moviesList[index].movieID)
            }
        }
        UserDefaults.standard.removeObject(forKey: "movies")
    }
}
