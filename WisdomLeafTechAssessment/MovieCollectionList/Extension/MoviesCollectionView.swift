//
//  MoviesCollectionView.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import UIKit

extension MoviesCollectionVC : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = viewModel?.movieData[indexPath.item]
        cell.viewModel = viewModel
        cell.favoriteMovieData = movie
        cell.movieTitle.text = "\(movie?.Title ?? "No title") \(movie?.Year ?? "No year")"
        // Load poster image
        viewModel?.fetchMoviePoster(movie: movie!, completion: { (posterImage) in
            cell.posterImage.image = posterImage
        })
        // Update favorite button appearance
        cell.updateFavoriteButtonAppearance()
        
        return cell
    }
}


extension MoviesCollectionVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = moviesCollectionView.frame.width * 0.48
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insetSpace = moviesCollectionView.frame.width * 0.01
        let inset = UIEdgeInsets(top: insetSpace, left: insetSpace, bottom: insetSpace, right: insetSpace)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return moviesCollectionView.frame.width * 0.04
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return moviesCollectionView.frame.width * 0.01 // Ensure spacing between items is consistent
    }
}

extension MoviesCollectionVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        let movie = viewModel?.movieData[indexPath.item]
        detailVC.viewModel = MovieDetailViewModel(imageLoader: PosterImageLoader())
        detailVC.viewModel?.movieData = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


