//
//  ProjectApp.swift
//  Project
//
//  Created by Andrew Jowe on 2/25/24.
//

import FirebaseCore
import SwiftUI

@main
struct ProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TestView()
        }
    }
}
