//
//  ViewController.swift
//  TinderClone
//
//  Created by admin on 15.03.24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let grayView = UIView()
        grayView.backgroundColor = .gray
    
        let subviews = [UIColor.systemGray, UIColor.darkGray, UIColor.black].map { color in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        
        let topStackdView = UIStackView(arrangedSubviews: subviews)
        topStackdView.distribution = .fillEqually
        topStackdView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let buttonStackView = HomeBottomControlsStackView()
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackdView, blueView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.fillSuperview()
        
    }


}
