//
//  MockUserGateway.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 21/03/2023.
//

import Combine
@testable import CleanSwiftUI

final class MockUserGateway: UserGatewayProtocol, Mock {
    enum Action: Equatable {
        case addUser(user: User)
        case getAllUsers
        case deleteUser(id: String)
        case updateUser(user: User)
    }
    
    let actions: MockActions<Action>
    
    var addUserResult: AnyPublisher<Void, Error>!
    var getAllUsersResult: AnyPublisher<[User], Error>!
    var deleteUserResult: AnyPublisher<User?, Error>!
    var updateUserResult: AnyPublisher<Void, Error>!
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    func add(_ user: CleanSwiftUI.User) -> AnyPublisher<Void, Error> {
        register(.addUser(user: user))
        return addUserResult
    }
    
    func all() -> AnyPublisher<[CleanSwiftUI.User], Error> {
        register(.getAllUsers)
        return getAllUsersResult
    }
    
    func delete(byID id: String) -> AnyPublisher<CleanSwiftUI.User?, Error> {
        register(.deleteUser(id: id))
        return deleteUserResult
    }
    
    func update(_ user: CleanSwiftUI.User) -> AnyPublisher<Void, Error> {
        register(.updateUser(user: user))
        return updateUserResult
    }
}


