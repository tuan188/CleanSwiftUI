//
//  MockRepoGateway.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import Combine
@testable import CleanSwiftUI

final class MockRepoGateway: RepoGatewayProtocol, Mock {
    enum Action: Equatable {
        case getRepo(page: Int, perPage: Int)
        case getEvents(url: String, page: Int, perPage: Int)
    }
    
    let actions: MockActions<Action>
    var getReposResult: AnyPublisher<[CleanSwiftUI.Repo], Error>!
    var getEventsResult: AnyPublisher<[CleanSwiftUI.Event], Error>!
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    func getRepos(page: Int, perPage: Int) -> AnyPublisher<[CleanSwiftUI.Repo], Error> {
        register(.getRepo(page: page, perPage: perPage))
        return getReposResult
    }
    
    func getEvents(url: String, page: Int, perPage: Int) -> AnyPublisher<[CleanSwiftUI.Event], Error> {
        register(.getEvents(url: url, page: page, perPage: perPage))
        return getEventsResult
    }
}
