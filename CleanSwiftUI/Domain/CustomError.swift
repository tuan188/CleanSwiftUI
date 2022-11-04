//
//  CustomError.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 04/11/2022.
//

import Foundation

struct CustomError: Error, LocalizedError {
    let message: String
  
    var errorDescription: String? { message }
}
