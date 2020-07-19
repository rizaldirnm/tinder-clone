//
//  HomeNavigationStackView.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 13/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

protocol HomeNavigationStackViewDelegate: class {
    func showSetting()
    func showMessage()
}

class HomeNavigationStackView: UIStackView {
    //MARK: - Properties
    
    weak var delegate: HomeNavigationStackViewDelegate?
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        messageButton.setImage(#imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.addTarget(self, action: #selector(handleMessage), for: .touchUpInside)
        
        [settingsButton, UIView(), tinderIcon, UIView(), messageButton].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleSettings(){
        delegate?.showSetting()
    }
    
    @objc func handleMessage(){
        delegate?.showMessage()
    }
}
