//
//  FavoriteMovieCollectionVC+Extension.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 02/08/24.
//

import UIKit

extension FavoriteMovieViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.favoriteMovieData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "fvoriteMovieCell", for: indexPath) as! FavoriteMovieCell
        let movie = viewModel?.favoriteMovieData[indexPath.item]
        
        viewModel?.fetchImageFromURL(movie: movie!, completion: { (posterImage) in
            cell.favoriteMoviePoster.image = posterImage
        })
        
        cell.favoriteMovieTitleNYear.text = "\(movie?.title ?? "No title")\(" ")\(movie?.year ?? "No year")"
        return cell
    }
}

extension FavoriteMovieViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = favoriteMovieCollectionView.frame.width * 0.47
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = favoriteMovieCollectionView.frame.width * 0.01
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return favoriteMovieCollectionView.frame.width * 0.03
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return favoriteMovieCollectionView.frame.width * 0.015 // Ensure spacing between items is consistent
    }
}
