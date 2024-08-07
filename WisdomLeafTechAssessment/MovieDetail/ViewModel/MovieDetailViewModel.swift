import UIKit

class MovieDetailViewModel {
    
    var movieData: MovieArray?
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func fetchMoviesPoster(movie: MovieArray, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: movie.Poster) else {
            completion(nil)
            return
        }
        imageLoader.fetchImageWithURL(url: url, completion: completion)
    }
}
