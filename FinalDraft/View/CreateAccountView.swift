import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button("Create Account") {
                    Task {
                        await createAccount()
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarTitle("Create Account", displayMode: .inline)
        }
    }
    
    private func createAccount() async {
        let (user, error) = await AuthApi.shared.createAccount(username: username, password: password)
        if let error = error {
            // Show error message
            errorMessage = error
        } else if user != nil {
            // Account creation was successful
            print("Account created for: \(username)")
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
