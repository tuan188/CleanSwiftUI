//
//  MainView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Product") {
                    NavigationLink {
                        ProductListView()
                    } label: {
                        Text("Products")
                    }
                }
            }
            .navigationTitle("Templates")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
