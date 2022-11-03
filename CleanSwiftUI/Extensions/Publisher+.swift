//
//  Publisher+.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import Combine

extension Publisher {
    func ignoreFailure() -> AnyPublisher<Output, Never> {
        self.catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    func sink() -> AnyCancellable {
        return self.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}
