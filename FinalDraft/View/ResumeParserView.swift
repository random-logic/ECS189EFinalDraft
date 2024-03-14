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

    var body: some View {
        VStack {
            Text("Experience: \(experience)")
            Text("Education: \(education)")
            Text("Skills: \(skills)")
            Text("Coursework: \(coursework)")
            Button(action: {
                self.isPickerPresented = true
            }) {
                Text("Upload PDF")
            }
            .sheet(isPresented: $isPickerPresented) {
                DocumentPicker(document: $document, text: $text, experience: $experience, education: $education, skills: $skills, coursework: $coursework)
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
                parent.experience = await extractExperience()
                parent.education = await extractEducation()
                parent.skills = await extractSkills()
                parent.coursework = await extractCoursework()
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
        
        func extractExperience() async -> String {
            let apiKey = "AIzaSyA7KtP-leaQgC2MU_4TCSjLELXSRvRjTyQ"
            let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)

            let prompt = "Given the following resume, write a list of all the experience items in it. Separate the job title, company, description, start date, and end date with a semicolon. Any fields that don't exist should be an empty string. Separate each experience item with a caret. For example, your response should look like this: Software Engineer; Google; Worked on Google Cloud team; Aug 2011; Jun 2015^Software Engineer Intern; Amazon; Worked on AWS team; Aug 2008; Jun 2009^ [START RESUME] \(parent.text)"
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
            return ""
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
    }
}
