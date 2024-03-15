import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var errorMessage: String?
    @State private var accountCreated = false // Used to trigger navigation
    @ObservedObject var viewModel = CreateAccountViewModel()

    var body: some View {
        
            VStack {
                TextField("Email", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("First Name", text: $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastname)
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
                .background(Color.indigo)
                .cornerRadius(10)
                
                // Hidden NavigationLink to trigger navigation on account creation
                NavigationLink(destination: ContentViewDemo(), isActive: $accountCreated) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarTitle("Create Account", displayMode: .inline)
        
    }
    
    private func createAccount() async {
        await viewModel.createAccount(username: username, password: password, name: firstname, student_id: "0") { user, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = nil
                } else if user != nil {
                    self.accountCreated = true
                }
            }
        }
    }
}
