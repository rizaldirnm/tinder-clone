//
//  User.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 14/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

struct User {
    var name: String
    var age: Int
    var email: String
    let uid: String
    let profileImageURL: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageURL = dictionary["imageUrl"] as? String ?? ""
    }
}
