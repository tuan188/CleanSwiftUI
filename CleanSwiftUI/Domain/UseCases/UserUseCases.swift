//
//  UserUseCases.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 23/03/2023.
//

import Combine

// MARK: - Add user
protocol AddUser {
    var userGateway: UserGatewayProtocol { get }
}

extension AddUser {
    func addUser(_ user: User) -> AnyPublisher<Void, Error> {
        userGateway.add(user)
    }
}

// MARK: - Get users
protocol GetUsers {
    var userGateway: UserGatewayProtocol { get }
}

extension GetUsers {
    func getUsers() -> AnyPublisher<[User], Error> {
        userGateway.all()
    }
}

// MARK: - Delete user
protocol DeleteUser {
    var userGateway: UserGatewayProtocol { get }
}

extension DeleteUser {
    func deleteUser(byID id: String) -> AnyPublisher<User?, Error> {
        userGateway.delete(byID: id)
    }
}

// MARK: - Update user
protocol UpdateUser {
    var userGateway: UserGatewayProtocol { get }
}

extension UpdateUser {
    func updateUser(_ user: User) -> AnyPublisher<Void, Error> {
        userGateway.update(user)
    }
}
