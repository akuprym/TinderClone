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

struct CardViewModel {
    let photoName: String
    let attributedString: NSMutableAttributedString
    let textAllignment: NSTextAlignment
}
