//
//  Double+.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation

extension Double {
    var currency: String {
        return String(format: "$%.02f", self)
    }
}
