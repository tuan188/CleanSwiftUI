//
//  UpdateUser.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import Combine

protocol UpdateUser {
    var userGateway: UserGatewayProtocol { get }
}

extension UpdateUser {
    func updateUser(_ user: User) -> AnyPublisher<Void, Error> {
        userGateway.update(user)
    }
}
