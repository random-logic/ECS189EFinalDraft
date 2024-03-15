import SwiftUI
import PDFKit
import MobileCoreServices
import GoogleGenerativeAI
import UniformTypeIdentifiers

struct ResumeParserView: View {
    @State private var text: String = ""
    @State private var experience: String = ""
    @State private var education: String = ""
    @State private var skills: String = ""
    @State private var coursework: String = ""
    @State private var document: PDFDocument? = nil
    @State private var isPickerPresented: Bool = false
    
    // Loading state for each section
    @State private var isLoadingExperience = false
    @State private var isLoadingEducation = false
    @State private var isLoadingSkills = false
    @State private var isLoadingCoursework = false
    
    @Binding var user: UserModel?
    
    var body: some View {
        VStack {
            if isLoadingExperience {
                ProgressView("Loading Experience...")
            } else {
                Text("Experience: \(experience)")
            }
            
            if isLoadingEducation {
                ProgressView("Loading Education...")
            } else {
                Text("Education: \(education)")
            }
            
            if isLoadingSkills {
                ProgressView("Loading Skills...")
            } else {
                Text("Skills: \(skills)")
            }
            
            if isLoadingCoursework {
                ProgressView("Loading Coursework...")
            } else {
                Text("Coursework: \(coursework)")
            }
            
            Button(action: {
                self.isPickerPresented = true
            }) {
                Text("Upload PDF")
            }
            .sheet(isPresented: $isPickerPresented) {
                DocumentPicker(document: $document, text: $text, experience: $experience, education: $education, skills: $skills, coursework: $coursework, user: $user, isLoadingExperience: $isLoadingExperience, isLoadingEducation: $isLoadingEducation, isLoadingSkills: $isLoadingSkills, isLoadingCoursework: $isLoadingCoursework)
            }
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var document: PDFDocument?
    @Binding var text: String
    @Binding var experience: String
    @Binding var education: String
    @Binding var skills: String
    @Binding var coursework: String
    @Binding var user: UserModel?
    // Bindings for loading states
    @Binding var isLoadingExperience: Bool
    @Binding var isLoadingEducation: Bool
    @Binding var isLoadingSkills: Bool
    @Binding var isLoadingCoursework: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            parent.document = PDFDocument(url: url)
            parent.text = extractTextFromPDF(document: parent.document)
            Task {
                await self.extractAll()
            }
        }

        func extractTextFromPDF(document: PDFDocument?) -> String {
            guard let document = document else { return "" }
            let pageCount = document.pageCount
            var text = ""
            for i in 0..<pageCount {
                guard let page = document.page(at: i) else { continue }
                guard let pageText = page.string else { continue }
                text += pageText
            }
            return text
        }
        
        func extractAll() async {
            parent.isLoadingExperience = true
            parent.experience = await extractExperience()
            parent.isLoadingExperience = false
            
            parent.isLoadingEducation = true
            parent.education = await extractEducation()
            parent.isLoadingEducation = false
            
            parent.isLoadingSkills = true
            parent.skills = await extractSkills()
            parent.isLoadingSkills = false
            
            parent.isLoadingCoursework = true
            parent.coursework = await extractCoursework()
            parent.isLoadingCoursework = false
        }
        
        func extractExperience() async -> String {
            let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ"
            let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

            let prompt = "Given the following resume, write a list of all the experience items in it. Separate the job title, company, description, start date, and end date with a semicolon (DO NOT put a caret or semicolon after the last experience item). Any fields that don't exist should be an empty string. Separate each experience item with a caret. For example, your response should look like this: Software Engineer; Google; Worked on Google Cloud team; Aug 2011; Jun 2015^Software Engineer Intern; Amazon; Worked on AWS team; Aug 2008; Jun 2009^ [START RESUME] \(parent.text)"
            do {
                let response = try await model.generateContent(prompt)
                if let responseText = response.text {
                    return responseText
                }
            } catch {
                print("Error: \(error)")
            }
            return ""
        }
        
        func extractEducation() async -> String {
            let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ"
            let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

            let prompt = "Given the following resume, write a list of all the education items in it. Separate the school, degree, field of study, description, start date, and end date with a semicolon. Any fields that don't exist should be an empty string. Separate each education item with a caret. For example, your response should look like this: University of California, Davis; Bachelor of Science, Computer Science; Aug 2011; Jun 2015^Harvard University; Master of Science, Computer Science; Aug 2015; Jun 2017^ [START RESUME] \(parent.text)"
            do {
                let response = try await model.generateContent(prompt)
                if let responseText = response.text {
                    return responseText
                }
            } catch {
                print("Error: \(error)")
            }
            return ""
        }

        func extractSkills() async -> String {
            let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ"
            let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

            let prompt = "Given the following resume, write a list of all the skills with each item being separated by a semicolon and space. For example, your response should look like this: Microsoft Excel; HTML; CSS; Microsoft Word [START RESUME] \(parent.text)"
            do {
                let response = try await model.generateContent(prompt)
                if let responseText = response.text {
                    return responseText
                }
            } catch {
                print("Error: \(error)")
            }
            fillSkills()
            return ""
        }
        
        func fillSkills() {
            let skillsString = "Microsoft Excel; HTML; CSS; Microsoft Word"
            let newSkills = skillsString.split(separator: ";").map { String($0.trimmingCharacters(in: .whitespaces)) }
            parent.user?.skills.append(contentsOf: newSkills)
            for skill in parent.user?.skills ?? [] {
                print("Skill: \(skill)")
            }
        }
        
        func extractCoursework() async -> String {
            let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ"
            let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

            let prompt = "Given the following resume, write a list of all the coursework with each item being separated by a semicolon and space. For example, your response should look like this: Introduction to C++; Operating Systems; Web Development; Classical Physics [START RESUME] \(parent.text)"
            do {
                let response = try await model.generateContent(prompt)
                if let responseText = response.text {
                    return responseText
                }
            } catch {
                print("Error: \(error)")
            }
            return ""
        }
        
        func fillCoursework() {
            let skillsString = "Microsoft Excel; HTML; CSS; Microsoft Word"
            let newSkills = skillsString.split(separator: ";").map { String($0.trimmingCharacters(in: .whitespaces)) }
            parent.user?.skills.append(contentsOf: newSkills)
            for skill in parent.user?.skills ?? [] {
                print("Skill: \(skill)")
            }
        }
    }
}
