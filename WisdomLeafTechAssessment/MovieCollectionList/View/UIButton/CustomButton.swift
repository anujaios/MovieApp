//
//  UiButton.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 02/08/24.
//

import UIKit

struct CustomButton {
    static func createButtonForBarButtonItem(systemImageName:String,target:Any,barButtonItem:UIBarButtonItem,performAction:Selector){
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: systemImageName), for: .normal)
        button.tintColor = .black
        button.addTarget(target, action:performAction , for: .touchUpInside)
        barButtonItem.customView = button
    }
}
