import SwiftUI
import FirebaseAuth

// Define a ViewModel to handle login logic and data
class LoginViewModel: ObservableObject {
    // Handles all the concurrency for you
    func login(username: String, password: String, callback: @escaping (UserModel?, String?) -> Void) {
        Task {
            let (user, error) = await AuthApi.shared.login(username: username, password: password)
            await MainActor.run {
                callback(user, error)
            }
        }
    }
}

class LogoutViewModel: ObservableObject {
    func logout() -> String? {
        return AuthApi.shared.logout()
    }
}

// Define a ViewModel to handle create account logic and data
class CreateAccountViewModel: ObservableObject {
    // Handles all the concurrency for you
    func createAccount(username: String, password: String, callback: @escaping (User?, String?) -> Void) {
        Task {
            let (user, error) = await AuthApi.shared.createAccount(username: username, password: password)
            await MainActor.run {
                callback(user, error)
            }
        }
    }
}
