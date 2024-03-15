//
//  HomeViewDemo.swift
//  FinalDraft
//
//  Created by Ethan He on 3/15/24.
//

import Foundation

import SwiftUI

struct HomeViewDemo: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Welcome!")
                    .font(.custom(titleFontName, size: 36))
                    .padding(.bottom, 20)
                
                NavigationLink(destination: LoginView(username: "a@ucdavis.edu", password: "123456", loginViewModel: LoginViewModel())) {
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                NavigationLink(destination: OcrView()) {
                    Text("OCR View")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                }

                NavigationLink(destination: CreateAccountView()) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.indigo)
                        .cornerRadius(15.0)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    HomeViewDemo()
}
