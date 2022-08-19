//
//  View+.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

extension View {
    func alert(error: Binding<IDError?>) -> some View {
        self
            .alert(item: error) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

struct IDError: LocalizedError, Identifiable {
    let error: Error
    
    var id: String {
        error.localizedDescription
    }
    
    var errorDescription: String? {
        error.localizedDescription
    }
}
