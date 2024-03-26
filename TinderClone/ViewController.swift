//
//  ViewController.swift
//  TinderClone
//
//  Created by admin on 15.03.24.
//

import UIKit

class HomeController: UIViewController {

    let topStackdView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttonStackView = HomeBottomControlsStackView()
    
    let users = [
    User(name: "Jane", age: 27, profession: "Artist", photoName: "profile_photo"),
    User(name: "Alise", age: 26, profession: "Dancer", photoName: "profile_photo2")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupProfileCards()
    }
    
    fileprivate func setupProfileCards() {
        users.forEach { user in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: user.photoName)
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
// MARK: - Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackdView, cardDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardDeckView)
    }

}
