//
//  MockRepo.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import Foundation
@testable import CleanSwiftUI

extension Repo {
    static let stub = Repo(
        id: 1,
        name: "Repo 1",
        fullName: "Repo 1",
        url: "",
        eventUrl: "",
        stars: 1,
        forks: 1,
        owner: nil
    )
}
