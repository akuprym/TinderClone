//
//  CardView.swift
//  TinderClone
//
//  Created by admin on 22.03.24.
//

import UIKit

class CardView: UIView {

    let imageView = UIImageView(image: UIImage(named: "profile_photo"))
    let informationLabel = UILabel()
    
    fileprivate let treshold: CGFloat = 75
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.contentMode = .scaleAspectFit
        imageView.fillSuperview()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        informationLabel.numberOfLines = 0
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
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
