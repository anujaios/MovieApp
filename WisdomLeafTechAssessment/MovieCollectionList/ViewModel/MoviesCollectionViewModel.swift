//
//  MoviesCollectionViewModel.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import UIKit

protocol MoviesViewModelDelegate {
    func didUpdateMovies()
    func didGetError(error:Error)
}

class MovieCollectionListViewModel {
    
    private let networkManager : NetworkManager?
    private let imageLoader :ImageLoader?
    private(set) var movieData : [MovieArray] = []{
        didSet{
            delegate?.didUpdateMovies()
        }
    }
    var delegate:MoviesViewModelDelegate?
    
    init(networkManager:NetworkManager,moviePosterLoader:ImageLoader) {
        self.networkManager = networkManager
        self.imageLoader = moviePosterLoader
    }
    
    func fetchMoviesData(searchTitle:String){
        networkManager?.fetchMoviesData(searchTitle: searchTitle) {[weak self] (result) in
            switch result{
            case .failure(let err):
                DispatchQueue.main.async {
                    self?.delegate?.didGetError(error: err)
                }
            case .success(let result):
                DispatchQueue.main.async {
                    self?.movieData = result.Search
                }
            }
        }
    }
    
    //load Movie Poster 
    func fetchMoviePoster(movie:MovieArray,completion:@escaping (UIImage?) -> Void){
        guard let url = URL(string: movie.Poster) else {
            completion(nil)
            return
        }
        imageLoader?.fetchImageWithURL(url: url, completion:completion)
    }
    
    func isFavorite(movie:MovieArray) -> Bool {
        return MovieManager.shared.isFavorite(movie: movie)
    }
    func addToFavorite(movie:MovieArray){
        MovieManager.shared.addMovieToFavourites(movie: movie)
    }
    func removeFromFavorite(movie:MovieArray){
        MovieManager.shared.removeMovieFromFavourites(movie: movie)
    }
}
