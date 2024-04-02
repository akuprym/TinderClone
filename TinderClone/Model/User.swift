//
//  User.swift
//  TinderClone
//
//  Created by admin on 26.03.24.
//

import UIKit

struct User: ProducesCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let photoNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: "\(name)", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]))
        
        return CardViewModel(photoNames: photoNames, attributedString: attributedText, textAllignment: .left)
    }
}

