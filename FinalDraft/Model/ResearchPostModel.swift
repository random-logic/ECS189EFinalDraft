import FirebaseFirestore

struct ResearchPostModel : DictionaryConvertible {
    var id: String
    var title: String
    var description: String
    var major: [String]
    var owner: String
    var updatedAt: Timestamp
    
    // Convenience initializer to parse data from Firestore document
    init?(documentId: String, documentData: [String: Any]) {
        self.id = documentId
        
        guard let title = documentData["title"] as? String,
              let description = documentData["description"] as? String,
              let major = (documentData["majors"] as? NSArray)?.compactMap({ $0 as? String }),
              let owner = documentData["owner"] as? String,
              let updatedAt = documentData["updatedAt"] as? Timestamp else {
            return nil
        }
        
        self.title = title
        self.description = description
        self.major = major
        self.owner = owner
        self.updatedAt = updatedAt
    }
    
    func toString() -> String {
        return """
        Title: \(self.title)\n
        Description: \(self.description)\n
        Majors: \(self.major)\n
        """
    }
}

