import FirebaseAuth

class AuthApi {
    static let shared = AuthApi()
    
    /// Creates a new user account with the specified email and password.
    /// - Parameters:
    ///   - username: The email address for the user's account.
    ///   - password: The password for the user's account.
    /// - Returns: A tuple containing the newly created `User` object upon success, or an error message upon failure.
    func createAccount(username: String, password: String, name: String, major: [String] = [], role: String, student_id: String?, department: String?) async -> (UserModel?, String?) {
        do {
            // Try to create account
            let authResult = try await Auth.auth().createUser(withEmail: username, password: password)
            
            print("Account created successfully")
            
            return await UserApi.shared.createUser(name: name, role: role, major: major, student_id: student_id, department: department)
        } catch {
            print("Account creation failed: \(error.localizedDescription)")
            
            return (nil, error.localizedDescription)
        }
    }
    
    /// Logs in an existing user with the specified email and password.
    /// - Parameters:
    ///   - username: The email address for the user's account.
    ///   - password: The password for the user's account.
    /// - Returns: A tuple containing the logged-in `User` object upon success, or an error message upon failure.
    func login(username: String, password: String) async -> (UserModel?, String?) {
        do {
            // Try to login
            let authResult = try await Auth.auth().signIn(withEmail: username, password: password)
            
            print("User logged in successfully")
            
            let uid = authResult.user.uid
            
            return await UserApi.shared.readUser(uid: uid)
        } catch {
            print("Login failed: \(error.localizedDescription)")
            
            return (nil, error.localizedDescription)
        }
    }
    
    /// Logs out the currently authenticated user.
    /// - Returns: An error message upon failure, or `nil` if the logout operation was successful.
    func logout() -> String? {
        do {
            try Auth.auth().signOut()
            
            print("User signed out successfully")
            
            return nil
        } catch {
            print("Logout failed: \(error.localizedDescription)")
            
            return error.localizedDescription
        }
    }
    
    func getUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func getUid() -> String? {
        return self.getUser()?.uid
    }
}
