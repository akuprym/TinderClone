//
//  HomeBottomControlsStackView.swift
//  TinderClone
//
//  Created by admin on 20.03.24.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 120).isActive = true
       
        
        let subviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "boost_circle") ].map { img in
            let button = UIButton(type: .system)
            button.setImage(img, for: .normal)
            return button
        }
        
        let button = UIButton(type: .system)
        // bottom row of buttons
        let bottomSubviews = [UIColor.red, .green, .blue, .yellow, .purple].map { color in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        bottomSubviews.forEach { v in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
