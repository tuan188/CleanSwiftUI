//
//  User+CoreData.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Foundation

extension User {
    init?(entity: CDUser) {
        guard let id = entity.id else {
            return nil
        }
        
        self.id = id
        self.name = entity.name ?? ""
        self.gender = Gender(rawValue: Int(entity.gender)) ?? .unknown
        self.birthday = entity.birthday ?? Date()
    }
    
    func map(to entity: CDUser) {
        entity.id = self.id
        entity.name = self.name
        entity.gender = Int64(self.gender.rawValue)
        entity.birthday = self.birthday
    }
}
