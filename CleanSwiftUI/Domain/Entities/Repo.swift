//
//  Repo.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 27/10/2022.
//

import Foundation
import Then

struct Repo {
    struct Owner: Codable {
        var id = 0
        var login = ""
        var avatarUrl = ""
        
        enum CodingKeys: String, CodingKey {
            case id
            case login
            case avatarUrl = "avatar_url"
        }
    }
    
    var id = 0
    var name = ""
    var fullName = ""
    var url = ""
    var stars = 0
    var forks = 0
    var owner: Owner?
}

extension Repo: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case url
        case stars = "stargazers_count"
        case forks
        case owner
    }
}

extension Repo: Then, Identifiable { }
