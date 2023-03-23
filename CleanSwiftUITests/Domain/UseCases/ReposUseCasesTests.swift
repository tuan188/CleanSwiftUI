//
//  ReposUseCasesTests.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import XCTest
import Combine
@testable import CleanSwiftUI

final class ReposUseCasesTests: XCTestCase, GetRepos, GetEvents {
    var repoGateway: RepoGatewayProtocol { mockRepoGateway }
    private var mockRepoGateway: MockRepoGateway!
    
    func test_getRepos_success() throws {
        let page = 1
        let perPage = 10
        let repos = [Repo.stub]
        mockRepoGateway = MockRepoGateway(expected: [.getRepo(page: page, perPage: 10)])
        mockRepoGateway.getReposResult = Just(repos).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = try awaitPublisher(getRepos(page: page, perPage: perPage))
        
        mockRepoGateway.verify()
        XCTAssertEqual(repos, result)
    }
    
    func test_getRepos_fail() throws {
        let page = 1
        let perPage = 10
        let repos = [Repo.stub]
        mockRepoGateway = MockRepoGateway(expected: [.getRepo(page: page, perPage: 10)])
        mockRepoGateway.getReposResult = Just(repos).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = try awaitPublisher(getRepos(page: page, perPage: perPage))
        
        mockRepoGateway.verify()
        XCTAssertEqual(repos, result)
    }
    
    func test_getEvents_success() throws {
        let url = "http"
        let page = 1
        let perPage = 10
        let events = [Event.stub]
        mockRepoGateway = MockRepoGateway(expected: [.getEvents(url: url, page: page, perPage: perPage)])
        mockRepoGateway.getEventsResult = Just(events).setFailureType(to: Error.self).eraseToAnyPublisher()

        let result = try awaitPublisher(getEvents(url: url, page: page, perPage: perPage))
        
        mockRepoGateway.verify()
        XCTAssertEqual(result, events)
    }
    
    func test_getEvents_failed() throws {
        let url = "http"
        let page = 1
        let perPage = 10
        let mockError = MockError()
        mockRepoGateway = MockRepoGateway(expected: [.getEvents(url: url, page: page, perPage: perPage)])
        mockRepoGateway.getEventsResult = Fail(error: mockError).eraseToAnyPublisher()

        do {
            let _ = try awaitPublisher(getEvents(url: url, page: page, perPage: perPage))
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockRepoGateway.verify()
    }
}
