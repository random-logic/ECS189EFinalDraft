//
//  File.swift
//  FinalDraft
//
//  Created by Ethan He on 3/14/24.
//

import SwiftUI
import Foundation

struct HomeView: View {

    var body: some View {
            // Use a vertical stack to arrange elements
            VStack {
                Button(action: {
                    // Add your action here
                    print("Button was tapped")
                }) {
                    Text("Tap me!")
                        .foregroundColor(.white)
                        .padding() // Add some space inside the button
                        .background(Color.blue) // Set the background color of the button
                        .cornerRadius(10) // Round the corners of the button
                }
            }
        }
    }
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
