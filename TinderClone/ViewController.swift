//
//  ViewController.swift
//  TinderClone
//
//  Created by admin on 15.03.24.
//

import UIKit

class ViewController: UIViewController {

    let topStackdView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttonStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupProfileCards()
    }
    
    fileprivate func setupProfileCards() {
        let cardView = CardView(frame: .zero)
        cardDeckView.addSubview(cardView)
        cardView.fillSuperview()
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
