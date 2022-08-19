//
//  Assembler+Gateway.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation

extension Assembler {
    func productGateway() -> ProductGatewayProtocol {
        return ProductGateway()
    }
}
