//
//  MockUser.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import Foundation
@testable import CleanSwiftUI

extension User {
    static let stub = User(
        id: "1",
        name: "User 1",
        gender: .male,
        birthday: Date()
    )
}
