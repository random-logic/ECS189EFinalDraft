import FirebaseFirestore

class UserApi {
    static let shared = UserApi()
    
    func createUser(name: String, role: String, major: [String] = [], student_id: String?, department: String?) async -> (UserModel?, String?) {
        var data: [String: Any] = [
            "name": name,
            "role": role
        ]
        
        if role == "student" {
            guard let student_id = student_id else {
                return (nil, "Student must have student_id")
            }
            
            data["student_id"] = student_id
            data["major"] = major
            data["applied"] = []
            data["saved"] = []
        }
        else if role == "professor" {
            guard let department = department else {
                return (nil, "Professor must have department")
            }
            
            data["department"] = department
        }
        else {
            return (nil, "Invalid role")
        }
                
        guard let user_uid = AuthApi.shared.getUid() else {
            return (nil, "Must have created account for this action")
        }
        
        let db = Firestore.firestore()
        let documentReference = db.collection("User").document(user_uid)
        
        do {
            try await documentReference.setData(data)
            return (UserModel(documentId: user_uid, documentData: data), nil)
        }
        catch {
            return (nil, error.localizedDescription)
        }
    }

    func readUser(uid: String) async -> (UserModel?, String?) {
        let db = Firestore.firestore()
        let collection = db.collection("User")
        let docRef = collection.document(uid)
        
        do {
            guard let document = try await docRef.getDocument().data() else {
                return (nil, "Could not get document data")
            }
            
            guard let userModel = UserModel(documentId: uid, documentData: document) else {
                return (nil, "Could not convert document to UserModel")
            }
            
            return (userModel, nil)
        }
        catch {
            return (nil, error.localizedDescription)
        }
    }
    
    func deleteUser() async -> String? {
        guard let uid = AuthApi.shared.getUid() else {
            return "You need to be logged in to delete user"
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("User").document(uid)
        
        do {
            try await docRef.delete()
            return nil
        }
        catch {
            return error.localizedDescription
        }
    }
}
