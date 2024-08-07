//
//  MovieDelegateProtocol.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import Foundation

extension MoviesCollectionVC:MoviesViewModelDelegate{
    func didUpdateMovies() {
        self.activityIndicator.stopAnimating()
        self.dataNotFound.isHidden = true
        self.moviesCollectionView.reloadData()
    }
    
    func didGetError(error: Error) {
        self.activityIndicator.stopAnimating()
        self.dataNotFound.isHidden = false
        print(error.localizedDescription)
    }
}
