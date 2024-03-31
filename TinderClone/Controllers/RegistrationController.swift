//
//  RegistrationController.swift
//  TinderClone
//
//  Created by admin on 29.03.24.
//

import UIKit

class RegistrationController: UIViewController {

    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter email"
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
              view.addGestureRecognizer(tapGesture)
          }

          @objc func hideKeyboard() {
              view.endEditing(true)
          }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        
        let difference = bottomSpace - keyboardFrame.height
        self.view.transform = CGAffineTransform(translationX: 0, y: difference - 8)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
    ])
    
    fileprivate func setupLayout() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 1, green: 0.4528897405, blue: 0.4463171959, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}
