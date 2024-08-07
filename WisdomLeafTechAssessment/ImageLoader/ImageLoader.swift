//
//  ImageLoader.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import UIKit

protocol ImageLoader {
    func fetchImageWithURL(url:URL,completion:@escaping (UIImage?) -> Void)
}

class PosterImageLoader:ImageLoader{
    
    func fetchImageWithURL(url:URL,completion:@escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,let image = UIImage(data: data){
                DispatchQueue.main.async {
                    completion(image)
                }}
            else{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        .resume()
    }
}
