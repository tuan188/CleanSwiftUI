//
//  AppColorScheme.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Foundation

enum AppColorScheme: Int, Identifiable, CaseIterable {
    case system
    case light
    case dark
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}
