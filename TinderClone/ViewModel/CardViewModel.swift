//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 14/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

struct CardViewModel {
    
    let user: User
    
    let userInfoText: NSAttributedString
    
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
        
        self.userInfoText = attributedText
    }
}
