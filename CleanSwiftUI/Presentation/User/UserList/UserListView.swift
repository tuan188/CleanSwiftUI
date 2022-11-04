//
//  UserListView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 02/11/2022.
//

import SwiftUI
import Combine
import Factory

struct UserListView: View, GetUsers, AddUser, DeleteUser, UpdateUser {
    private enum ViewState {
        case isLoading, loaded
    }
    
    // Dependencies
    @Injected(Container.userGateway) var userGateway: UserGatewayProtocol
    
    // State
    @State private var cancelBag = CancelBag()
    @State private var users = [User]()
    @State private var state = ViewState.isLoading
    @State private var error: IDError?
    @State private var selectedUser: User?
    
    // Navigation
    @State private var showAddUser = false
    
    var body: some View {
        content
            .navigationTitle("User List")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddUser) {
                NavigationView {
                    AddUserView() { user in
                        addUser(user: user)
                    }
                }
            }
            .sheet(item: $selectedUser, onDismiss: {
                selectedUser = nil
            }, content: { user in
                NavigationView {
                    EditUserView(user: user) { updatedUser in
                        updateUser(user: updatedUser)
                    }
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddUser.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                loadUsers()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch state {
        case .isLoading:
            ProgressView()
                .progressViewStyle(.circular)
        case .loaded:
            userList
        }
    }
    
    @ViewBuilder
    private var userList: some View {
        if users.isEmpty {
            VStack {
                Spacer()
                Text("No users")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Button {
                    showAddUser.toggle()
                } label: {
                    Label("Add", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
        } else {
            List {
                ForEach(users) { user in
                    UserView(user: user)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUser = user
                        }
                }
                .onDelete(perform: deleteUser)
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Methods
private extension UserListView {
    func loadUsers() {
        getUsers()
            .handleFailure(error: $error)
            .sink { users in
                self.users = users
                self.state = .loaded
            }
            .store(in: cancelBag)
    }
    
    func addUser(user: User) {
        addUser(user)
            .handleFailure(error: $error)
            .sink {
                self.loadUsers()
            }
            .store(in: cancelBag)

    }
    
    func deleteUser(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let user = users[index]
        
        deleteUser(byID: user.id)
            .handleFailure(error: $error)
            .sink { _ in
                loadUsers()
            }
            .store(in: cancelBag)
        
        users.remove(atOffsets: offsets)
    }
    
    func updateUser(user: User) {
        updateUser(user)
            .handleFailure(error: $error)
            .sink {
                self.loadUsers()
            }
            .store(in: cancelBag)

    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
