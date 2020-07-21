//
//  SettingFooter.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 21/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

protocol SettingFooterDelegate: class {
    func handleLogout()
}

class SettingFooter: UIView {
    
    //MARK: - Properties
    
    weak var delegate: SettingFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        
        addSubview(spacer)
        spacer.setDimensions(height: 32, width: frame.width)
        
        addSubview(logoutButton)
        logoutButton.anchor(top: spacer.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:  - Actions
    @objc func handleLogout(){
        delegate?.handleLogout()
    }
    
}
