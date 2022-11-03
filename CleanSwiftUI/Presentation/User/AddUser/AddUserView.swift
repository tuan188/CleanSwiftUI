//
//  AddUserView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import SwiftUI

struct AddUserView: View {
    private enum Field: Hashable {
        case name
    }
    
    @Environment(\.dismiss) var dismiss
    
    // Init
    var onAdd: (User) -> Void
    
    // State
    @State private var name = ""
    @State private var gender = Gender.unknown
    @State private var birthday = Date()
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($focusedField, equals: .name)
                .task {
                    try? await Task.sleep(nanoseconds: 600_000_000)  // 0.5s
                    focusedField = .name
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
                Button("Add") {
                    addUser()
                }
                .disabled(name.isEmpty)
            }
        }
    }
}

// MARK: - Methods
private extension AddUserView {
    func addUser() {
        let user = User(name: name, gender: gender, birthday: birthday)
        onAdd(user)
        dismiss()
    }
}

//struct AddUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUserView()
//    }
//}
