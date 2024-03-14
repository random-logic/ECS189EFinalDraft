//
//  ApplicationModel.swift
//  Project
//
//  Created by Mac on 3/13/24.
//

import FirebaseFirestore

struct ApplicationModel: DictionaryConvertible {
    var id: String
    var applicant: String
    var researchPost: String
    
    init?(documentId: String, documentData: [String: Any]) {
        self.id = documentId
        guard let applicant = documentData["applicant"] as? String,
              let researchPost = documentData["researcHPost"] as? String else {
            return nil
        }
        self.applicant = applicant
        self.researchPost = researchPost
        
    }
    
   
    
}
