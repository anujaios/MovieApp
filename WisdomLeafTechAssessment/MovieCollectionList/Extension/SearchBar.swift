//
//  SearchBar.swift
//  WisdomLeafTechAssessment
//
//  Created by Mac on 06/08/24.
//

import UIKit

extension MoviesCollectionVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        fetchData()
        return true
    }
    
}
