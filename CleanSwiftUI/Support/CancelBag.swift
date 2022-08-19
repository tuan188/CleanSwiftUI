//
//  CancelBag.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation
import Combine

open class CancelBag {
    public var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
