//
//  FavoriteViewModel.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import UIKit

protocol FavoriteViewModelDelegate{
    func didFetchFavoriteMovies()
    func didFailToFetchFavoriteMovies(err:Error)
}

class FavoriteViewModel {
    
    private(set) var favoriteMovieData = [MovieBYID]()
    private let networkManager:NetworkManager?
    private let imageLoader:ImageLoader?
    var delegate :FavoriteViewModelDelegate?
    
    init(networkManager:NetworkManager,imageLoader:ImageLoader) {
        self.networkManager = networkManager
        self.imageLoader  = imageLoader
    }
    
    func fetchDataBYIdsStoreInUserDefault(){
        let favoriteIds = getFavoriteIds()
        networkManager?.fetchMovieData(for: favoriteIds) { [weak self](result) in
            switch result{
            case .failure(let err):
                self?.delegate?.didFailToFetchFavoriteMovies(err: err)
            case .success(let result):
                self?.favoriteMovieData = result
                self?.delegate?.didFetchFavoriteMovies()
            }
        }
    }
    
    func getFavoriteIds() -> [String]{
        return MovieManager.shared.getFavoritesMovieList()
    }
    
    func fetchImageFromURL(movie:MovieBYID,completion:@escaping (UIImage?) -> Void){
        guard let url = URL(string: movie.poster) else {
            print("error url")
            return
        }
        imageLoader?.fetchImageWithURL(url: url, completion: completion)
    }
}
