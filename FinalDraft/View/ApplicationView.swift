import SwiftUI
import GoogleGenerativeAI

struct ApplicationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var education: String = ""
    @State private var coverLetter: String = ""
    @State private var isLoading: Bool = false
    @State private var resume: String = "Name: John Doe, Address: 123 Main St, Sacramento, CA, Email: john.doe@example.com, Phone: (123) 456-7890, Objective: Experienced Software Engineer seeking to leverage proven skills in a challenging role, Skills: Java, Python, C++, SQL, HTML/CSS, JavaScript, Agile/Scrum, Git, Education: B.S. in Computer Science, University of California, Davis, 2016-2020, Experience: Software Engineer, Intel, Sacramento, CA, 2020-Present, Developed and maintained web applications"
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Education", text: $education)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1)
            } else {
                ScrollView {
                    Text(coverLetter.isEmpty ? "Your cover letter will appear here..." : coverLetter)
                        .padding()
                }
            }
            
            Button("Generate Cover Letter") {
                Task {
                    isLoading = true
                    coverLetter = await generateCoverLetter()
                    isLoading = false
                }
            }
            .disabled(firstName.isEmpty || lastName.isEmpty || education.isEmpty)
            .padding()
            
            Button("Apply") {
                applyForJob()
            }
            .disabled(coverLetter.isEmpty)
            .padding()
        }
    }
    
    func generateCoverLetter() async -> String {
        let resume = "Name: \(firstName) \(lastName), Education: \(education)"
        // Include other details as necessary
        
        let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ" // Use your actual API key
        let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
        let prompt = "Generate a cover letter based on the following resume (only include the greeting, body, and signature): \(resume)"
        
        do {
            let response = try await model.generateContent(prompt)
            if let responseText = response.text {
                return responseText
            }
        } catch {
            print("Error: \(error)")
        }
        return "Unable to generate cover letter at this time."
    }
    
    func applyForJob() {
        // Implement job application logic here
        print("Applying for the job with the generated cover letter...")
    }
}

