//
//  RepoGateway.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 27/10/2022.
//

import Foundation
import Factory
import RequestBuilder
import Combine

protocol RepoGatewayProtocol {
    func getRepos(page: Int, perPage: Int) -> AnyPublisher<[Repo], Error>
}

final class RepoGateway: RepoGatewayProtocol {
    struct GetReposResult: Codable {
        var items = [Repo]()
    }
    
    func getRepos(page: Int, perPage: Int) -> AnyPublisher<[Repo], Error> {
        APISessionManager.gitSessionManager
            .request()
            .add(path: Config.URLs.Git.getListRepo)
            .add(parameters: [
                "q": "language:swift",
                "per_page": perPage,
                "page": page
            ])
            .data(type: GetReposResult.self)
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Container {
    static let repoGateway = Factory { RepoGateway() as RepoGatewayProtocol }
}
