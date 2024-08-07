//
//  FavoriteMovieViewController.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 02/08/24.
//

import UIKit

class FavoriteMovieViewController: UIViewController{
    
    @IBOutlet weak var favoriteMovieCollectionView:UICollectionView!
    @IBOutlet weak var dataNotFound:UILabel!
     public var viewModel: FavoriteViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteViewModel(networkManager: NetworkManager(), imageLoader: PosterImageLoader())
        viewModel?.delegate = self
        viewModel?.fetchDataBYIdsStoreInUserDefault()
        
        navigationItem.title = "Favorite Movie List"
        navigationItem.backButtonDisplayMode = .minimal
        
        favoriteMovieCollectionView.delegate = self
        favoriteMovieCollectionView.dataSource = self
        favoriteMovieCollectionView.register(UINib(nibName: "FavoriteMovieCell", bundle: nil), forCellWithReuseIdentifier: "fvoriteMovieCell")
        
        dataNotFound.isHidden = true
    }
}

extension FavoriteMovieViewController:FavoriteViewModelDelegate{
    func didFetchFavoriteMovies() {
        DispatchQueue.main.async {
            self.dataNotFound.isHidden = true
            self.favoriteMovieCollectionView.reloadData()
        }
    }
    
    func didFailToFetchFavoriteMovies(err: Error) {
        DispatchQueue.main.async {
            self.dataNotFound.isHidden = false
            self.dataNotFound.text = "Fail To Fetch data"
        }
    }
    
    
}
