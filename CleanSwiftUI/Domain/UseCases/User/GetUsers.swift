//
//  GetUsers.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import Combine

protocol GetUsers {
    var userGateway: UserGatewayProtocol { get }
}

extension GetUsers {
    func getUsers() -> AnyPublisher<[User], Error> {
        userGateway.all()
    }
}
