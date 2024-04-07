//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by admin on 1.04.24.
//

import UIKit

class RegistrationViewModel {
    
    var image: UIImage? {
        didSet {
            imageObserver?(image)
        }
    }
    
    var imageObserver: ((UIImage?) -> ())?
    
    var fullName: String? { didSet { checkFormValidity() }}
    var email: String? { didSet { checkFormValidity() }}
    var password: String? { didSet { checkFormValidity() }}
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    // Reactive programming
    
    var isFormValidObserver: ((Bool) -> ())?
}
