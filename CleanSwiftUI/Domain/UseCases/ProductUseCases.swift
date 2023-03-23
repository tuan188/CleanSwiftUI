//
//  ProductUseCases.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 23/03/2023.
//

import Combine

protocol GetListProduct {
    var productGateway: ProductGatewayProtocol { get }
}

extension GetListProduct {
    func getProductList() -> AnyPublisher<[Product], Error> {
        productGateway.getListProduct()
    }
}
