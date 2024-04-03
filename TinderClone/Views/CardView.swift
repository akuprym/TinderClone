//
//  CardView.swift
//  TinderClone
//
//  Created by Anna Kupryianchyk on 22.03.24.
//  Copyright © 2024 Anna Kupryianchyk. All rights reserved.

import UIKit

class CardView: UIView {
     
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.photoNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAllignment
            
            (0..<cardViewModel.photoNames.count).forEach { _ in
                let barView = UIView()
                barView.backgroundColor = UIColor(white: 0, alpha: 0.1)
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] index, image in
            self.imageView.image = image
            
            self.barsStackView.arrangedSubviews.forEach { v in
                v.backgroundColor = .systemGray
            }
            self.barsStackView.arrangedSubviews[index].backgroundColor = .white
        }
    }

    fileprivate let imageView = UIImageView(image: UIImage(named: "profile_photo"))
    fileprivate let gradiendLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    fileprivate let treshold: CGFloat = 75
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
        
        setupBarsStackView()
        
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
//    var imageIndex = 0
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
            
//        imageIndex = min(imageIndex+1, cardViewModel.photoNames.count - 1)
//        } else {
//        imageIndex = max(0, imageIndex - 1)
//        }
//        let imageName = cardViewModel.photoNames[imageIndex]
//        imageView.image = UIImage (named: imageName )
//        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }
    
    //add a gradient layear
    
    fileprivate func setupGradientLayer() {
        gradiendLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiendLayer.locations = [0.6, 1]
        layer.addSublayer(gradiendLayer)
    }
    
    override func layoutSubviews() {
        gradiendLayer.frame = self.frame
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ subview in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChangedState(gesture)
        case .ended:
            handleEndedState(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChangedState(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation + conversion degrees to radians
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * CGFloat.pi / 180
        
        let rotationTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEndedState(_ gesture: UIPanGestureRecognizer) {
        
        let xFromCenter = imageView.center.x - self.center.x
        
        self.center = CGPoint(x: self.center.x + gesture.translation(in: nil).x, y: self.center.y + gesture.translation(in: nil).y)
        
        if self.center.x < treshold {
            // Dislike
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
                self.center = CGPoint(x: self.frame.origin.x - self.frame.width/2, y: self.center.y + self.treshold)
            }
        } else if self.center.x > self.frame.width - treshold {
            // Like
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
                self.center = CGPoint(x: self.frame.maxX + self.frame.width/2, y: self.imageView.center.y + self.treshold)
            }
        } else {
            transform = .identity
            self.center = imageView.center
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
