import FirebaseFirestore

struct UserModel : DictionaryConvertible {
    var id: String
    var name: String
    var role: String
    var major: [String]
    var student_id: String?
    var department: String?
    var applied: [String]
    var saved: [String]
    var postings: [String]
    
    // Convenience initializer to parse data from Firestore document
    init?(documentId: String, documentData: [String: Any]) {
        self.id = documentId
        
        guard let name = documentData["name"] as? String,
              let role = documentData["role"] as? String else {
            return nil
        }
        
        self.name = name
        self.role = role
        
        if role == "Student" {
            guard let student_id = documentData["student_id"] as? String,
                let major = (documentData["majors"] as? NSArray)?.compactMap({ $0 as? String }),
                let applied = (documentData["applied"] as? NSArray)?.compactMap({ $0 as? String }),
                let saved = (documentData["saved"] as? NSArray)?.compactMap({ $0 as? String }) else {
                return nil
            }
            
            self.student_id = student_id
            self.major = major
            self.applied = applied
            self.saved = saved
            self.postings = []
        }
        else if role == "Professor" {
            guard let department = documentData["department"] as? String ,
                  let postings = (documentData["postings"] as? NSArray)?.compactMap({ $0 as? String }) else {
                return nil
            }
            
            self.department = department
            self.major = []
            self.applied = []
            self.saved = []
            self.postings = postings
        }
        else {
            return nil
        }
    }
}
