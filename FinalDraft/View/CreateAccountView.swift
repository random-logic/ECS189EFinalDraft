import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var name = ""
    @State private var studentId = "" // Added for student_id
    @State private var errorMessage: String?
    @State private var accountCreated = false
    @ObservedObject var viewModel = CreateAccountViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Name", text: $name) // TextField for name
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Student ID", text: $studentId) // TextField for student_id
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
        await viewModel.createAccount(username: username, password: password, name: name, student_id: studentId) { user, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Show error message
                    self.errorMessage = error
                } else if user != nil {
                    // Account creation was successful
                    self.accountCreated = true
                }
            }
        }
    }
}
