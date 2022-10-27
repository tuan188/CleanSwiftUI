//
//  GetRepos.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 27/10/2022.
//

import Foundation
import Combine

protocol GetRepos {
    var repoGateway: RepoGatewayProtocol { get }
}

extension GetRepos {
    func getRepos(page: Int, perPage: Int) -> AnyPublisher<[Repo], Error> {
        repoGateway.getRepos(page: page, perPage: perPage)
    }
}
