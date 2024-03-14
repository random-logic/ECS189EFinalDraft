//
//  ResumeApi.swift
//  Project
//
//  Created by Mac on 3/13/24.
//
//
import FirebaseFirestore

class ResumeApi {
    static let shared = ResumeApi()
    
    func createResume(id: String, name: String, user: String)  async -> String? {
        guard let user = AuthApi.shared.getUser() else {
            return "No logged in user"
        }
        let data: [String: Any] = [
            "id": id,
            "name": name,
            "user": user
        ]
        do {
            let db = Firestore.firestore()
            let collection = db.collection("Resume")
            try await collection.addDocument(data: data)
        } catch {
            return error.localizedDescription
        }
        return nil
    }
    
    func updateResume(_ resume: ResumeModel) async -> String? {
        let db = Firestore.firestore()
        let collection = db.collection("Resume")
        let documentRef = collection.document(resume.id)
        
        do {
            try await documentRef.setData(resume.toDictionary())
            return nil
        } catch {
            return error.localizedDescription
        }
    }
    
    func deleteResume(_ resume: ResumeModel) async -> String? {
        let db = Firestore.firestore()
        let collection = db.collection("Resume")
        let documentRef = collection.document(resume.id)
        do {
            try await documentRef.delete()
            return nil
        } catch {
            return error.localizedDescription
        }
    }
}
