//
//  MainView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 19/08/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            moreView
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
        }
    }
    
    private var homeView: some View {
        NavigationView {
            List {
                Section("Repo (API)") {
                    NavigationLink {
                        RepoListView()
                    } label: {
                        Text("Repo List")
                    }
                }
                
                Section("User (CoreData)") {
                    NavigationLink {
                        UserListView()
                    } label: {
                        Text("User List")
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var moreView: some View {
        NavigationView {
            MoreView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
