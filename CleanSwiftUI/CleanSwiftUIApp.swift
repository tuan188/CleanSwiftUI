//
//  CleanSwiftUIApp.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

@main
struct CleanSwiftUIApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
