//
//  CardView.swift
//  TinderClone
//
//  Created by admin on 22.03.24.
//

import UIKit

class CardView: UIView {

    fileprivate let imageView = UIImageView(image: UIImage(named: "profile_photo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.fillSuperview()
        
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
        
        if self.center.x < 75 {
            // Dislike
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
                self.center = CGPoint(x: self.frame.origin.x - self.frame.width/2, y: self.center.y + 75)
                self.imageView.alpha = 0
            }
        } else if self.center.x > self.frame.width - 75 {
            // Like
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
                self.center = CGPoint(x: self.frame.maxX + self.frame.width/2, y: self.imageView.center.y + 75)
                self.imageView.alpha = 0
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
