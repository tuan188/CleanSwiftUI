//
//  UserGateway.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Combine
import Factory
import CoreStore

protocol UserGatewayProtocol {
    func add(_ user: User) -> AnyPublisher<Void, Error>
    func all() -> AnyPublisher<[User], Error>
    func delete(byID id: String) -> AnyPublisher<User?, Error>
}

final class UserGateway: UserGatewayProtocol {
    func add(_ user: User) -> AnyPublisher<Void, Error> {
        CoreStoreDefaults.dataStack
            .reactive
            .perform { transaction -> Void in
                let entity = transaction.create(Into<CDUser>())
                user.map(to: entity)
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func all() -> AnyPublisher<[User], Error> {
        CoreStoreDefaults.dataStack
            .reactive
            .perform { transaction -> [User] in
                let entities = try transaction.fetchAll(
                    From<CDUser>()
                        .orderBy(.ascending(\.name))
                )
                
                return entities.map { User(entity: $0) }
                    .compactMap { $0 }
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func delete(byID id: String) -> AnyPublisher<User?, Error> {
        CoreStoreDefaults.dataStack
            .reactive
            .perform { transaction -> User? in
                let entity = try transaction.fetchOne(
                    From<CDUser>()
                        .where(\.id == id)
                )
                
                transaction.delete(entity)
                return entity.flatMap { User(entity: $0) }
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

extension Container {
    static let userGateway = Factory { UserGateway() as UserGatewayProtocol }
}

