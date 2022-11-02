//
//  User.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Foundation
import Then

enum Gender: Int {
    case unknown = 0
    case male = 1
    case female = 2
    
    var name: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        default:
            return "Unknown"
        }
    }
}

struct User: Identifiable {
    var id = UUID().uuidString
    var name = ""
    var gender = Gender.unknown
    var birthday = Date()
}
