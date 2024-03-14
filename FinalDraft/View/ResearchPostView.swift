//
//  ResearchPostView.swift
//  Project
//
//  Created by Andrew Jowe on 3/8/24.
//

import SwiftUI

struct ResearchPostView: View {
    @ObservedObject var getResearchPostViewModel = GetResearchPostViewModel()
    @State var posts: String?
    @State var err: String?
    
    var body: some View {
        Text("When pressed, querries the first post that contains 'test' and outputs here")
        
        if let posts = self.posts {
            Text(posts)
        }
        
        Button(action: {
            getResearchPostViewModel.getPosts(titleContains: "Test") { posts, err in
                self.posts = posts.first?.toString()
                self.err = err
            }
        }) {
            Text("Get Posts")
        }
        
        if let err = self.err {
            Text(err)
        }
    }
}

#Preview {
    ResearchPostView()
}
