//
//  MoreView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import SwiftUI

struct MoreView: View {
    @AppStorage("colorScheme") private var colorScheme = AppColorScheme.system
    
    var body: some View {
        List {
            Picker("Theme", selection: $colorScheme) {
                ForEach(AppColorScheme.allCases) { scheme in
                    Text(scheme.title)
                        .tag(scheme)
                }
            }
        }
        .navigationTitle("More")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
