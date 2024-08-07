//
//  MovieDetailViewController.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 01/08/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var view1:UIView!
    @IBOutlet weak var waltLabel:UILabel!
    @IBOutlet weak var actionLabel:UILabel!
    @IBOutlet weak var posterImage:UIImageView!
    @IBOutlet weak var movieDescription:UILabel!
    
    var viewModel : MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        BackgroundImage.setupBackgroundImageView(view: view)
        
        movieTitle.text = viewModel?.movieData?.Title
        view1.layer.cornerRadius = 5
        view1.clipsToBounds = true
        
        waltLabel.text = "Walt Disney Animation\nStudios (2021)"
        waltLabel.numberOfLines = 0
        
        actionLabel.text = "Action,Adventure,Animation,\nComedy,Family,Fantasy"
        actionLabel.numberOfLines = 0
        
        movieDescription.text = MovieDefaultDetails.description
        
        guard let viewModel = viewModel else {
            print("err in view model")
            return
        }
        guard let movie = viewModel.movieData else {
            print("movie data is nil")
            return
        }
        
        viewModel.fetchMoviesPoster(movie: movie, completion: { [weak self] posterImage in
            self?.posterImage.image = posterImage
        })
        
    }
    
    
    

    

}
