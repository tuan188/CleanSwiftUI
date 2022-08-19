//
//  Assembler.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import Foundation

final class Assembler: ObservableObject {
    enum Mode {
        case preview
        case production
    }
    
    static let production = Assembler(mode: .production)
    static let preview = Assembler(mode: .preview)
    
    let mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
    }
}
