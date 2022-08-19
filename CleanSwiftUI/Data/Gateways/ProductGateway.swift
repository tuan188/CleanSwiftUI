//
//  ProductGateway.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation
import Combine

protocol ProductGatewayProtocol {
    func getProductList() -> AnyPublisher<[Product], Error>
}

struct ProductGateway: ProductGatewayProtocol {
    func getProductList() -> AnyPublisher<[Product], Error> {
        Future<[Product], Error> { promise in
            let products = [
                Product(id: 0, name: "iPhone", price: 999),
                Product(id: 1, name: "MacBook", price: 2999)
            ]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                promise(.success(products))
            }
        }
        .eraseToAnyPublisher()
    }
}
