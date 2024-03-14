//
//  RecommendedViewModel.swift
//  Project
//
//  Created by Mac on 3/13/24.
//

import SwiftUI

class RecommendedViewModel: ObservableObject {
    
    func getRecommendedPosts(keywords: [String], interests: [String], callback: @escaping ([ResearchPostModel], String?) -> Void) -> Void {
        Task {
            let (posts, error) = await ResearchPostApi.shared.recommendPosts(keywords: keywords, interests: interests)
            await MainActor.run {
                callback(posts, error)
            }
        }
    }
}

