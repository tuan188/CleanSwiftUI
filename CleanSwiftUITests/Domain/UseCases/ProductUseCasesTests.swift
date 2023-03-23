//
//  ProductUseCasesTests.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import XCTest
import Combine
@testable import CleanSwiftUI

final class ProductUseCasesTests: XCTestCase, GetListProduct {
    var productGateway: ProductGatewayProtocol { mockProductGateway }
    private var mockProductGateway: MockProductGateway!
    
    func test_getListProduct_success() throws {
        let products = [Product.stub]
        mockProductGateway = MockProductGateway(expected: [.getListProduct])
        mockProductGateway.getListProductResult = Just(products).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = try awaitPublisher(getProductList())
        
        mockProductGateway.verify()
        XCTAssertEqual(result, products)
    }
    
    func test_getListProduct_failed() throws {
        let mockError = MockError()
        mockProductGateway = MockProductGateway(expected: [.getListProduct])
        mockProductGateway.getListProductResult = Fail(error: mockError).eraseToAnyPublisher()
        
        do {
            let _ = try awaitPublisher(getProductList())
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockProductGateway.verify()
    }
}

