import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var error: String?
    @State private var isAuthenticated = false // State to control navigation
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
            VStack {
                TextField("Email", text: $username)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = self.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    loginViewModel.login(username: username, password: password) { user, error in
                        if user != nil {
                            self.isAuthenticated = true
                        } else {
                            self.error = error
                        }
                    }
                }) {
                    Text("Login")
                }
                .padding()
                
                // Hidden NavigationLink that will activate upon successful login
                NavigationLink(destination: ContentViewDemo(), isActive: $isAuthenticated) {
                    EmptyView()
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Login")
    }
}

// Assume LoginViewModel is defined elsewhere in your project
