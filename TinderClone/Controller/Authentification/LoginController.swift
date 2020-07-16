//
//  LoginController.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 15/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Passwrod", isSecureField: true)
    
    private let authButton: AuthButton = {
        let btn = AuthButton(title: "Login", type: .system)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let goToRegistrationButton: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
    
        attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return btn
    }()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        
        configureUI()
    }
    
    //MARK: - Action
    @objc func handleLogin(){
        
    }
    
    @objc func handleShowRegistration(){
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 100)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}
