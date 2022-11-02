//
//  AddUser.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Combine

protocol AddUser {
    var userGateway: UserGatewayProtocol { get }
}

extension AddUser {
    func add(_ user: User) -> AnyPublisher<Void, Error> {
        userGateway.add(user)
    }
}
