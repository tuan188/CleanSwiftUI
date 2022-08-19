//
//  GetProductList.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation
import Combine

protocol GetProductList {
    var productGateway: ProductGatewayProtocol { get }
}

extension GetProductList {
    func getProductList() -> AnyPublisher<[Product], Error> {
        productGateway.getProductList()
    }
}
