import SwiftUI

// Create a View to display the login UI
struct LoginView: View {
    @State var username: String
    @State var password: String
    @State var error: String?
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
                    self.error = error
                }
            }) {
                Text("Login")
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Login")
    }
}

#Preview {
    LoginView(username: "user",
              password: "1234",
              loginViewModel: LoginViewModel())
}
