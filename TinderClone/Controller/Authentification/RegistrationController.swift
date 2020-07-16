//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 15/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return btn
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)
    private let authButton: AuthButton = {
        let btn = AuthButton(title: "Register", type: .system)
        btn.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        return btn
    }()
    
    private let goToLoginButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
    
        attributedTitle.append(NSAttributedString(string: " Login", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    @objc func handleSelectPhoto(){
        
    }
    
    @objc func handleRegisterUser(){
        
    }
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        configureGradientLayer()
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, fullnameTextField, passwordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
}
