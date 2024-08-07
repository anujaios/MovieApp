//
//  MovieManager.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 02/08/24.
//

import Foundation

class MovieManager{
    
    static let shared = MovieManager()
    
    private init(){}
    
    let keyForStoreFavMovie :String = "favorites"
    
    func addMovieToFavourites(movie:MovieArray){
        var favoritesMovieList = getFavoritesMovieList()
        
        if(!favoritesMovieList.contains(movie.imdbID)){
            favoritesMovieList.append(movie.imdbID)
            UserDefaults.standard.set(favoritesMovieList, forKey: keyForStoreFavMovie)
        }
    }
    
    func removeMovieFromFavourites(movie:MovieArray){
        
        var favoritesMovieList = getFavoritesMovieList()
        guard (!favoritesMovieList.isEmpty) else {
            return
        }
        if let index = favoritesMovieList.firstIndex(of: movie.imdbID){
            favoritesMovieList.remove(at: index)
            UserDefaults.standard.set(favoritesMovieList, forKey: keyForStoreFavMovie)
        }
        
    }
    
    func isFavorite(movie:MovieArray) -> Bool{
        let favoritesMovieList = getFavoritesMovieList()
        return favoritesMovieList.contains(movie.imdbID)
    }
    
    func getFavoritesMovieList() -> [String]{
        return UserDefaults.standard.stringArray(forKey: keyForStoreFavMovie) ?? []
    }
}
