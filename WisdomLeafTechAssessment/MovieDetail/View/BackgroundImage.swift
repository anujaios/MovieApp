//
//  BackgroundImage.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 05/08/24.
//

import UIKit

struct BackgroundImage {
    static func setupBackgroundImageView(view:UIView){
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "backgroundImage")
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.alpha = 1
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                                        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.sendSubviewToBack(backgroundImage)
    }

}
