//
//  User.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Foundation
import Then

enum Gender: Int, Identifiable, CaseIterable {
    case unknown = 0
    case male = 1
    case female = 2
    
    var title: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        default:
            return "Unknown"
        }
    }
    
    var id: Int { rawValue }
}

struct User: Identifiable {
    var id = UUID().uuidString
    var name = ""
    var gender = Gender.unknown
    var birthday = Date()
}
