//
//  ResumeModel.swift
//  Project
//
//  Created by Mac on 3/13/24.
//

import FirebaseFirestore


struct ResumeModel: DictionaryConvertible {
    var id: String
    var name: String
    var user: String
    
    init?(documentId: String, documentData: [String: Any]) {
        self.id = documentId
        
        guard let name = documentData["name"] as? String,
              let user = documentData["user"] as? String else {
            return nil
        }
        self.name = name
        self.user = user
    }
}
