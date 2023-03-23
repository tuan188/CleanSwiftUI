//
//  MockError.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import Foundation
import XCTest

struct MockError: Error {
    let id = UUID().uuidString
    var message = ""
    
    func isEqual(to error: Error) -> Bool {
        if let error = error as? MockError {
            return self == error
        }
        
        return false
    }
}

extension MockError: Equatable {}

extension Error {
    func isEqual(to mockError: MockError) -> Bool {
        if let error = self as? MockError {
            return error == mockError
        }
        
        return false
    }
}
