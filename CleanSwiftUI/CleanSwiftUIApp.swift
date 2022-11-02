//
//  CleanSwiftUIApp.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI
import CoreStore

@main
struct CleanSwiftUIApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @AppStorage("colorScheme") private var colorScheme = AppColorScheme.system
    
    var appColorScheme: ColorScheme? {
        switch colorScheme {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    init() {
        configCoreStore()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(appColorScheme)
        }
    }
}

// MARK: - Methods
private extension CleanSwiftUIApp {
    func configCoreStore() {
        CoreStoreDefaults.dataStack = DataStack(
            xcodeModelName: "Model",
            bundle: Bundle.main,
            migrationChain: []
        )
        
        do {
            try CoreStoreDefaults.dataStack.addStorageAndWait(
                SQLiteStore(
                    fileName: "CleanSwiftUI.sqlite",
                    localStorageOptions: .allowSynchronousLightweightMigration
                )
            )
        } catch {
            print(error)
        }
    }
}
