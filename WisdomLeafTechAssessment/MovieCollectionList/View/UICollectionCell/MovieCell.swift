//
//  MovieCell.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 30/07/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage:UIImageView!
    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var favouriteButton:UIButton!

    var favoriteMovieData : MovieArray?
    var viewModel : MovieCollectionListViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        updateFavoriteButtonAppearance()
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let favoriteMovieData = favoriteMovieData else {
            print("Movie does not contain data")
            return
        }
        guard let viewModel = viewModel else {
            print("error in viewmodel")
            return
        }
        if(viewModel.isFavorite(movie: favoriteMovieData)){
            viewModel.removeFromFavorite(movie: favoriteMovieData)
            UIView.animate(withDuration: 0.3) {
                self.favouriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                self.favouriteButton.tintColor = .black
            }
        }
        else{
            viewModel.addToFavorite(movie: favoriteMovieData)
            UIView.animate(withDuration: 0.3) {
                self.favouriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                self.favouriteButton.tintColor = .red
            }
        }
    }
    
    
     func updateFavoriteButtonAppearance(){
        guard let favorite = favoriteMovieData else {
            return
        }
        guard let viewModel = viewModel else {
            print("error in viewmodel")
            return
        }
        let isFavorite = viewModel.isFavorite(movie: favorite)
        self.favouriteButton.setImage(isFavorite ? UIImage(systemName: "suit.heart.fill"):UIImage(systemName: "suit.heart"), for: .normal)
        if isFavorite{
            self.favouriteButton.tintColor = .red
        }else{
            self.favouriteButton.tintColor = .black
        }
    }
    
}
