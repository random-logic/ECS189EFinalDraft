//
//  ContentView.swift
//  Project
//
//  Created by Andrew Jowe on 2/25/24.
//

import SwiftUI

struct TestView: View {
    @State var error: String?
    @ObservedObject var logoutViewModel: LogoutViewModel = LogoutViewModel()
    @ObservedObject var createResearchPostViewModel: CreateResearchPostViewModel = CreateResearchPostViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView(username: "user", password: "password", loginViewModel: LoginViewModel())) {
                    Text("Go to Login")
                }
                .padding()
                
                NavigationLink(destination: ResearchPostView()) {
                    Text("Research Post View")
                }
                .padding()
                
                Button(action: {
                    self.createResearchPostViewModel.create(title: "Test Title", description: "Test Desc", majors: ["CS", "CSE"], callback: { err in
                        self.error = err
                    })
                }) {
                    Text("Create Research Post")
                }
                .padding()
                
                Button(action: {
                    self.error = self.logoutViewModel.logout()
                }) {
                    Text("Logout")
                }
                .padding()
                
                if let error = self.error {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    TestView()
}
