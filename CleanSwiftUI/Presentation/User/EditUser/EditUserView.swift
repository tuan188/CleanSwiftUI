//
//  EditUserView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import SwiftUI
import Combine

struct EditUserView: View {
    @Environment(\.dismiss) var dismiss
    
    // Init
    let user: User
    var onUpdate: (User) -> Void
    
    // State
    @State private var name = ""
    @State private var gender = Gender.unknown
    @State private var birthday = Date()
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
        case name
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($focusedField, equals: .name)
                .task {
                    try? await Task.sleep(nanoseconds: 600_000_000)  // 0.5s
                    focusedField = .name
                }
                .submitLabel(.done)
                .onSubmit {
                    updateUser()
                }
            
            Picker("Gender", selection: $gender) {
                ForEach(Gender.allCases) { gender in
                    Text(gender.title)
                        .tag(gender)
                }
            }
            
            DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Update") {
                    updateUser()
                }
                .disabled(name.isEmpty)
            }
        }
        .onLoad {
            name = user.name
            gender = user.gender
            birthday = user.birthday
        }
    }
}

// MARK: - Methods
private extension EditUserView {
    func updateUser() {
        let user = self.user.with {
            $0.name = name
            $0.gender = gender
            $0.birthday = birthday
        }
        
        onUpdate(user)
        dismiss()
    }
}

//struct EditUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditUserView()
//    }
//}
