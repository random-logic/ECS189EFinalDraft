import FirebaseFirestore

class ResearchPostApi {
    static let shared = ResearchPostApi()
    
    func create(title: String, description: String, majors: [String]) async -> String? {
        guard let user = AuthApi.shared.getUser() else {
            return "No logged in user"
        }
        
        let data: [String: Any] = [
            "title": title,
            "description": description,
            "majors": majors,
            "owner": user.uid,
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        do {
            let db = Firestore.firestore()
            let collection = db.collection("ResearchPost")
            try await collection.addDocument(data: data)
        } catch {
            return error.localizedDescription
        }
        
        return nil
    }
        
    func readPosts(titleContains: String) async -> ([ResearchPostModel], String?) {
        do {
            let db = Firestore.firestore()
            let collection = db.collection("ResearchPost")
            let querySnapshot = try await collection.getDocuments()
            var res: [ResearchPostModel] = [] // Correct declaration
                        
            for document in querySnapshot.documents {
                let id = document.documentID
                let data = document.data()
                // Access title field correctly and check if it contains the substring
                if let researchPost = ResearchPostModel(documentId: id, documentData: data) {
                    let title = researchPost.title
                    if title.lowercased().contains(titleContains.lowercased()) {
                        res.append(researchPost)
                    }
                }
            }
                        
            return (res, nil)
        } catch {
            return ([], error.localizedDescription)
        }
    }
    
    func updatePost(_ post: ResearchPostModel) async -> String? {
        let db = Firestore.firestore()
        let collection = db.collection("ResearchPost")
        let documentRef = collection.document(post.id)
        
        do {
            try await documentRef.setData(post.toDictionary())
            return nil
        } catch {
            return error.localizedDescription
        }
    }
    
    func deletePost(_ post: ResearchPostModel) async -> String? {
        let db = Firestore.firestore()
        let collection = db.collection("ResearchPost")
        let documentRef = collection.document(post.id)
        
        do {
            try await documentRef.delete()
            return nil
        } catch {
            return error.localizedDescription
        }
    }
}
