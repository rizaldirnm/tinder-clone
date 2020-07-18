//
//  HomeController.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 13/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    private let deckView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCard()
        checkIfUserIsLoggin()
        fetchUser()
//        logout()
    }
    
    //MARK: - API
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { (user) in
            print("DEBUG: User is \(user.name)")
        }
    }
    
    func checkIfUserIsLoggin(){
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            print("DEBUG: User is logged in")
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("DEBUG: Failed to sign out...")
        }
    }
    
    //MARK: - Helpers
    
    func configureCard() {
//        let user1 = User(name: "Jane Down", age: 22, images: [#imageLiteral(resourceName: "jane3"), #imageLiteral(resourceName: "jane1")])
//        let user2 = User(name: "Megan Rawr", age: 24, images: [#imageLiteral(resourceName: "kelly1"), #imageLiteral(resourceName: "lady5c")])
//        
//        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
//        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
//        
//        
//        deckView.addSubview(cardView1)
//        deckView.addSubview(cardView2)
//        cardView1.fillSuperview()
//        cardView2.fillSuperview()
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
    
    func presentLoginController(){
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}
