//
//  GetEvents.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 01/11/2022.
//

import Foundation
import Combine

protocol GetEvents {
    var repoGateway: RepoGatewayProtocol { get }
}

extension GetEvents {
    func getEvents(url: String, page: Int, perPage: Int) -> AnyPublisher<[Event], Error> {
        repoGateway.getEvents(url: url, page: page, perPage: perPage)
    }
}
