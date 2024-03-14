import SwiftUI

// Define a ViewModel to handle create account logic and data
class CreateResearchPostViewModel: ObservableObject {
    // Handles all the concurrency for you
    func create(title: String, description: String, majors: [String], callback: @escaping (String?) -> Void) -> Void {
        Task {
            let error = await ResearchPostApi.shared.create(title: title, description: description, majors: majors)
            await MainActor.run {
                callback(error)
            }
        }
    }
}

class GetResearchPostViewModel: ObservableObject {
    func getPosts(titleContains: String, callback: @escaping ([ResearchPostModel], String?) -> Void) -> Void {
        Task {
            let (posts, error) = await ResearchPostApi.shared.readPosts(titleContains: titleContains)
            await MainActor.run {
                callback(posts, error)
            }
        }
    }
   
}
