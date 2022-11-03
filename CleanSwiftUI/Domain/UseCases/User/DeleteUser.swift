//
//  DeleteUser.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import Foundation
import Combine

protocol DeleteUser {
    var userGateway: UserGatewayProtocol { get }
}

extension DeleteUser {
    func deleteUser(byID id: String) -> AnyPublisher<User?, Error> {
        userGateway.delete(byID: id)
    }
}
