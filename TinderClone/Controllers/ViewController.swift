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
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Jane", age: 24, profession: "Artist", photoNames: ["profile_photo"]),
            User(name: "Alisa", age: 26, profession: "Dancer", photoNames: ["profile_photo2"]),
            Advertiser(title: "Make Your Day", brandName: "TikTok", posterPhotoNames: ["advertiser_photo"])
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map { $0.toCardViewModel() }
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackdView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupProfileCards()
    }
    
    @objc func handleSettings() {
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupProfileCards() {
        cardViewModels.forEach { cardVM in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
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
