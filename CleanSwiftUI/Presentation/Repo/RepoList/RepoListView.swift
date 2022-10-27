//
//  RepoListView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 27/10/2022.
//

import SwiftUI
import Factory
import Combine

struct RepoListView: View, GetRepos {
    // Dependencies
    @Injected(Container.repoGateway) var repoGateway: RepoGatewayProtocol
    
    // State
    @State private var cancelBag = CancelBag()
    @State private var repos = [Repo]()
    @State private var error: IDError?
    
    var body: some View {
        List {
            ForEach(repos) { repo in
                RepoView(repo: repo)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Repo List")
        .onAppear {
            loadRepos()
        }
    }
}

// MARK: - Methods
extension RepoListView {
    func loadRepos() {
        getRepos(page: 1, perPage: 10)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IDError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { repos in
                self.repos = repos
            }
            .store(in: cancelBag)
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
