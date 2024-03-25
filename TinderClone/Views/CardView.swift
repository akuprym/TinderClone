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
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
       
        switch gesture.state {
        case .changed:
            handleChangedState(gesture)
        case .ended:
            handleEndedState()
        default:
            ()
        }
    }
    
    fileprivate func handleChangedState(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation + conversion degrees to radians
        let degrees: CGFloat = translation.x
        let angle = degrees * CGFloat.pi / 180
        
        let rotationTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransformation

//        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    fileprivate func handleEndedState() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
            self.transform = .identity
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
