//
//  MockProductGateway.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import Combine
@testable import CleanSwiftUI

final class MockProductGateway: ProductGatewayProtocol, Mock {
    enum Action: Equatable {
        case getListProduct
    }
    
    let actions: MockActions<Action>
    var getListProductResult: AnyPublisher<[Product], Error>!
    
    init(expected: [Action]) {
        actions = .init(expected: expected)
    }
    
    func getListProduct() -> AnyPublisher<[Product], Error> {
        register(.getListProduct)
        return getListProductResult
    }
}
