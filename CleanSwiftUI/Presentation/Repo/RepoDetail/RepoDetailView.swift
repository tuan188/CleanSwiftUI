//
//  RepoDetailView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 01/11/2022.
//

import SwiftUI
import Combine
import Factory

struct RepoDetailView: View, GetEvents {
    private enum ViewState {
        case isLoading, loaded
    }
    
    // Dependencies
    @Injected(Container.repoGateway) var repoGateway: RepoGatewayProtocol
    
    // Init
    let repo: Repo
    
    // State
    @State private var cancelBag = CancelBag()
    @State private var events = [Event]()
    @State private var error: IDError?
    @State private var state = ViewState.isLoading
    
    // Properties
    private let perPage = 20
    
    var body: some View {
        List {
            Section {
                VStack {
                    AsyncImage(url: URL(string: repo.owner?.avatarUrl ?? ""), scale: 2) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.5)
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                    
                    Text(repo.fullName)
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
                
                Text("Star")
                    .badge(repo.stars)
                
                Text("Fork")
                    .badge(repo.forks)
            }
            
            Section("Events") {
                if state == .isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(events) { event in
                        EventView(event: event)
                    }
                }
            }
            
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .alert(error: $error)
        .onAppear {
            loadEvents()
        }
    }
}

// MARK: - Methods
private extension RepoDetailView {
    func loadEvents() {
        getEvents(url: repo.eventUrl, page: 1, perPage: 10)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IDError(error: error)
                case .finished:
                    break
                }
            } receiveValue: { events in
                self.state = .loaded
                self.events = events
            }
            .store(in: cancelBag)
    }
}

//struct RepoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoDetailView()
//    }
//}
