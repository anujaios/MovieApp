//
//  APIManager.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 31/07/24.
//

import Foundation

enum NetworkError:Error {
    case BadURL
    case RequestFailed
    case ErrorDecoding
    case InValidResponse
}

class NetworkManager{
    let baseURL = "http://www.omdbapi.com/"
    let apiKey = "84b0f25e"
    func fetchMoviesData(searchTitle:String,completion:@escaping (Result<Movie,NetworkError>) -> Void){
        
        let formattedTitle = searchTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "don"
        //let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&t=\(formattedTitle)"
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(formattedTitle)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.BadURL))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                completion(.failure(.RequestFailed))
            }
            
            guard (response as? HTTPURLResponse) != nil else{
                completion(.failure(.InValidResponse))
                return
            }
            
            guard let data = data else{
                completion(.failure(.InValidResponse))
                return
            }
            
            do{
                let movieData = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movieData))
            }
            catch {
                completion(.failure(.ErrorDecoding))
            }
        }
        dataTask.resume()
    }
    
    func fetchMovieData(for ids: [String], completion: @escaping (Result<[MovieBYID], NetworkError>) -> Void) {

        let dispatchGroup = DispatchGroup()
        var fetchedMovies: [MovieBYID] = []
        var networkError: NetworkError?

        for id in ids {
            dispatchGroup.enter()
            let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(id)"
            //https://www.omdbapi.com/?apikey=84b0f25e&i=tt2229499
            
            guard let url = URL(string: urlString) else {
                networkError = .BadURL
                dispatchGroup.leave()
                continue
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    networkError = .RequestFailed
                    dispatchGroup.leave()
                    return
                }
                
                guard let data = data else {
                    networkError = .InValidResponse
                    dispatchGroup.leave()
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieBYID.self, from: data)
                    fetchedMovies.append(movie)
                } catch {
                    networkError = .ErrorDecoding
                }
                dispatchGroup.leave()
            }
            task.resume()
        }

        dispatchGroup.notify(queue: .main) {
            if let error = networkError {
                completion(.failure(error))
            } else {
                completion(.success(fetchedMovies))
            }
        }
    }

}
