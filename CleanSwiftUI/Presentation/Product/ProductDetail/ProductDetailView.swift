//
//  ProductDetailView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let product: Product
    
    var body: some View {
        List {
            Text(product.name)
            Text(product.price.currency)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Product Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
