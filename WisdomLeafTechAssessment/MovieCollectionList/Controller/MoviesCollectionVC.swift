//
//  ViewController.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 30/07/24.
//

import UIKit

class MoviesCollectionVC: UIViewController {
    
    @IBOutlet weak var moviesCollectionView:UICollectionView!
    @IBOutlet weak var movieCollectionViewTopConstraint:NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var dataNotFound: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    
    public var viewModel : MovieCollectionListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewmodel
        viewModel = MovieCollectionListViewModel(networkManager: NetworkManager(), moviePosterLoader: PosterImageLoader())
        viewModel?.delegate = self
        
        //delegate and datasource assign
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        //register collection cell
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        
        //delegate for searchbar
        searchBar.delegate = self
        searchBar.isHidden = true
        
        activityIndicator.isHidden = true
        setUpUI()
        setUpUIFavoriteButton()
        fetchData()
        
    }
    
    private func setUpUI(){
        //configuration for cancel button due to swift 5 has not ishidden property for barbuttonitem
        CustomButton.createButtonForBarButtonItem(systemImageName: "xmark", target: self, barButtonItem: cancelBarButtonItem, performAction: #selector(cancelButtonTapped))
        cancelBarButtonItem.customView?.isHidden = true
        //configuration for searchbutton
        CustomButton.createButtonForBarButtonItem(systemImageName: "magnifyingglass", target: self, barButtonItem: searchBarButtonItem, performAction: #selector(searchButtonTapped))
        
        dataNotFound.isHidden = true
    }
    private func setUpUIFavoriteButton(){
        FavoriteButton.tintColor = .red
        FavoriteButton.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.80).cgColor //magnesium
        FavoriteButton.layer.shadowOffset = CGSize(width: 2.0, height:2.0)
        FavoriteButton.layer.shadowRadius = 10
        FavoriteButton.layer.cornerRadius = 30
        FavoriteButton.layer.shadowOpacity = 1
        FavoriteButton.layer.masksToBounds = false
        
    }
    //objc method for cancel button
    @objc func cancelButtonTapped(){
        searchBar.resignFirstResponder()
        searchBar.text = ""
        UIView.animate(withDuration: 0.3) {
            self.searchBar.isHidden = true
            self.searchBarButtonItem.customView?.isHidden = false
            self.cancelBarButtonItem.customView?.isHidden = true
            self.movieCollectionViewTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    //objc method for search button
    @objc func searchButtonTapped(){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.searchBar.isHidden = false
            self.searchBarButtonItem.customView?.isHidden = true
            self.searchBarButtonItem.customView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.cancelBarButtonItem.customView?.isHidden = false
            
        } completion: { (done) in
        }
        UIView.animate(withDuration: 0.3) {
            self.movieCollectionViewTopConstraint.constant = self.view.frame.height * 0.07
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func getfavoriteMovieButtonTapped(_ sender: UIButton) {
        let favoriteMovieVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteMovieViewController") as! FavoriteMovieViewController
        navigationController?.pushViewController(favoriteMovieVC, animated: true)
    }
    
    //initially don data fetches
    public func fetchData(){
        self.activityIndicator.startAnimating()
        let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let searchTitle = searchText.isEmpty ? "don": searchText
        viewModel?.fetchMoviesData(searchTitle: searchTitle)
            }
        }
        





