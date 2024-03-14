import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationView { // Wrap your content in a NavigationView
            VStack(spacing: 20) {
                Spacer()

                NavigationLink(destination: LoginView(username: "user", password: "password", loginViewModel: LoginViewModel())) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }

                NavigationLink(destination: CreateAccountView()) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true) // Optionally hide the navigation bar
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
