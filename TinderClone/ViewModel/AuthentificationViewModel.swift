//
//  AuthentificationViewModel.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 18/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import Foundation

protocol AuthenticationViewModel {
    var formValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegistrationViewModal: AuthenticationViewModel {
    var email: String?
    var fullname: String?
    var password: String?
    
    var formValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false
    }
}
