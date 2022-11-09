//
//  LoginView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 07/11/2022.
//

import SwiftUI
import ValidatedPropertyKit

struct LoginView: View {
    // State
    @Validated(!.isEmpty && .isEmail)
    private var email = ""
    
    @Validated(.range(8...))
    private var password = ""
    
    @FocusState private var focusedField: Field?
    @State private var didTapLogin = false
    @State private var showAlert = false
    
    private enum Field: Hashable {
        case email
    }
    
    var body: some View {
        Form {
            Section(footer: VStack(alignment: .leading) {
                if didTapLogin && !_email.isValid {
                    Text("Invalid email")
                }
                
                if didTapLogin && !_password.isValid {
                    Text("Invalid password")
                }
            }) {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .email)
                    .task {
                        try? await Task.sleep(nanoseconds: 600_000_000)  // 0.5s
                        focusedField = .email
                    }
                
                SecureField("Password", text: $password)
            }
            
            Section {
                if didTapLogin {
                    loginButton
                        .validated(
                            self._email,
                            self._password
                        )
                } else {
                    loginButton
                }
                
                Button("Reset form") {
                    email = ""
                    password = ""
                    didTapLogin = false
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Login success", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(email)
        }
    }
    
    private var loginButton: some View {
        Button {
            print("Login", email, password)
            didTapLogin = true
            
            if _email.isValid && _password.isValid {
                showAlert.toggle()
            }
        } label: {
            Text("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
