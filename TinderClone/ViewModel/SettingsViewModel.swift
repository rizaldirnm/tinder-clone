//
//  SettingsViewModel.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 19/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

enum SettingsSection: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .profession: return "Profession"
        case .bio: return "Bio"
        case .age: return "Age"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct SettingsViewModel{
    
    private let user: User
    let section: SettingsSection
    
    let placeholderText: String
    
    var value: String?
    
    var shouldHideInputField: Bool {
        return section == .ageRange
    }
    
    var shouldHideSlider: Bool {
        return section != .ageRange
    }
    
    init(user: User, section: SettingsSection) {
        self.user = user
        self.section = section
        
        placeholderText = "Enter \(section.description.lowercased()).."
        
        switch section {
            
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .age:
            value = "\(user.age)"
        case .bio:
            value = user.bio
        case .ageRange:
            break
        }
    }
}
