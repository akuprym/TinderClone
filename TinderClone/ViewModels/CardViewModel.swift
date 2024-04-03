//
//  CardViewModel.swift
//  TinderClone
//
//  Created by admin on 27.03.24.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel 
}

class CardViewModel {
    let photoNames: [String]
    let attributedString: NSMutableAttributedString
    let textAllignment: NSTextAlignment
    
    init(photoNames: [String], attributedString: NSMutableAttributedString, textAllignment: NSTextAlignment) {
        self.photoNames = photoNames
        self.attributedString = attributedString
        self.textAllignment = textAllignment
    }
    
    var imageIndex = 0 {
        didSet {
            let imageName = photoNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }
    //Reactive Programming
    var imageIndexObserver: ((Int, UIImage?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, photoNames.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
