import SwiftUI

struct Professor {
    var name: String
    var project: String
}

struct ProjectOptionsView: View {
    let X: [Professor] = [Professor(name: "", project: "")]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 16)
                
                Text("Results")
                    .font(.system(size: 18, weight: .bold))
                
                List(X, id: \.name) { x in
                    Section(header: Text("Recommended Projects")) {
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Concurrency Research")
                                    .font(.headline)
                                Text("Sam King")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Autograder")
                                    .font(.headline)
                                Text("Matthew Butner")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Student Assistant")
                                    .font(.headline)
                                Text("Yelena Frid")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Section(header: Text("All Projects")) {
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Wine Research")
                                    .font(.headline)
                                Text("Jay Lopes")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Oceonography")
                                    .font(.headline)
                                Text("Laci Gerhart")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Nuclear Testing")
                                    .font(.headline)
                                Text("The Mad Man")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: RecommendedProjectsViewDemo()) {
                            VStack(alignment: .leading) {
                                Text("Sociology Research")
                                    .font(.headline)
                                Text("Nar Bayes")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                TabBar()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfessorDetailView: View {
    let professor: Professor
    
    var body: some View {
        VStack {
            Text("Professor: \(professor.name)")
                .font(.headline)
            Text("Project: \(professor.project)")
                .font(.subheadline)
        }
        .padding()
        .navigationTitle(professor.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOptionsView()
    }
}
