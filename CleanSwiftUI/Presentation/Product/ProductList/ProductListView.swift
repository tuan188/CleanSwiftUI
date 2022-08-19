//
//  ProductListView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var assembler: Assembler
    @State private var products = [Product]()
    @State private var error: IDError?
    @State private var selectedProduct: Product?
    @State private var cancelBag = CancelBag()
    
    var body: some View {
        List {
            ForEach(products) { product in
                Button {
                    selectedProduct = product
                } label: {
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(product.price.currency)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .alert(error: $error)
        .sheet(item: $selectedProduct, content: { product in
            NavigationView {
                ProductDetailView(product: product)
            }
        })
        .navigationTitle("Product List View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getProductList()
        }
    }
}

// MARK: - Methods
extension ProductListView {
    func getProductList() {
        getProductList()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IDError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { products in
                self.products = products
            }
            .store(in: cancelBag)
    }
}

extension ProductListView: GetProductList {
    var productGateway: ProductGatewayProtocol {
        assembler.productGateway()
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
