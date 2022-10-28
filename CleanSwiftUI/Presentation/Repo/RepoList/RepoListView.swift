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
    @State private var state = ViewState.isLoading
    @State private var page = 1
    
    private let perPage = 20
    
    enum ViewState {
        case isLoading, loaded, loadingMore, prepareLoadingMore
    }
    
    var body: some View {
        content
            .navigationTitle("Repo List")
    }
}

// MARK: - Views
private extension RepoListView {
    @ViewBuilder
    var content: some View {
        switch state {
        case .isLoading:
            loadingView()
        case .loaded, .loadingMore, .prepareLoadingMore:
            listView()
        }
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .onAppear {
                loadRepos()
            }
    }
    
    @ViewBuilder
    func listView() -> some View {
        List {
            ForEach(repos) { repo in
                RepoView(repo: repo)
            }
            
            if state == .loadingMore {
                ProgressView()
                    .progressViewStyle(.circular)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
            } else {
                Color.clear
                    .listRowSeparator(.hidden)
                    .padding()
                    .onAppear {
                        loadMoreRepos()
                        let _ = print("load more")
                    }
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - Methods
extension RepoListView {
    func loadRepos() {
        getRepos(page: page, perPage: perPage)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IDError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { repos in
                self.repos = repos
                state = .loaded
            }
            .store(in: cancelBag)
    }
    
    func loadMoreRepos() {
        guard state != .loadingMore else { return }
        
        state = .loadingMore

        getRepos(page: page + 1, perPage: perPage)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IDError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { repos in
                self.page += 1
                self.repos = self.repos + repos
                state = .loaded
            }
            .store(in: cancelBag)
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
