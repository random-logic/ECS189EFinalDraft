    import SwiftUI
    import WrappingStack
    import UniformTypeIdentifiers

    struct DocumentPicker: UIViewControllerRepresentable {
        var callback: (URL) -> Void

        func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
            let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
            picker.delegate = context.coordinator
            return picker
        }

        func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, UIDocumentPickerDelegate {
            var parent: DocumentPicker

            init(_ documentPicker: DocumentPicker) {
                self.parent = documentPicker
            }

            func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
                guard let url = urls.first else { return }
                parent.callback(url)
            }
        }
    }
    struct SectionView: View {
        let title: String
        @Binding var isLoading: Bool

        var body: some View {
            VStack {
                Text(title)
                    .font(.headline)
                    .padding()

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text("Content for \(title)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }

    struct StudentViewDemo: View {
        let titleFontName: String = "Poppins-Bold"
        let subtitleFontName: String = "Poppins-SemiBold"
        let bodyFontName: String = "Poppins-Regular"

        let titleFontSize: CGFloat = 24
        let subtitleFontSize: CGFloat = 18
        let bodyFontSize: CGFloat = 12

        let titleColor: Color = Color(red: 1/255, green: 159/255, blue: 171/255)
        let subtitleColor: Color = Color(red: 255/255, green: 255/255, blue: 255/255)
        let bodyColor: Color = Color(red: 129/255, green: 136/255, blue: 152/255)

        let skillsArray = [
            "Python", "C/C++", "JavaScript/Typescript", "HTML/CSS", "Dart", "R", "C#", "Java", "SQL",
            "React", "React Native", "Node.js", "Next.js", "Flutter", "Git", "VS Code", "Visual Studio", "IntelliJ", "Docker",
            "Google ML-Kit", "Firebase", "MongoDB", "Tailwind CSS", "Material UI", "Postgresql", "Apollo/Graphql", "Prisma",
            "Artificial Intelligence", "Machine Learning", "Statistical Modeling", "Linear Programming", "IOS Development",
            "Computer Architecture", "Regression/Variance Analysis", "Algorithm Design", "Operating Systems", "Computer Vision"
        ]
        let coursesArray = ["Artificial Intelligence", "Machine Learning", "Statistical Modeling", "Linear Programming", "IOS Development", "Computer Architecture", "Regression/Variance Analysis", "Algorithm Design", "Operating Systems", "Computer Vision"]
        
        @State private var navigateToEditNameAndPictureView = false
        @State private var navigateToEditAboutMeView = false
        @State private var navigateToEditExperienceItemView = false
        @State private var navigateToEditEducationItemView = false
        @State private var navigateToEditSkillsView = false
        @State private var navigateToEditCourseworkView = false
        @State private var showDocumentPicker = false
        @State private var resumeURL: URL?
        @State private var isLoadingAboutMe = false
        @State private var isLoadingExperience = false
        @State private var isLoadingEducation = false
        @State private var isLoadingSkills = false
        @State private var isLoadingCourses = false
        @State private var isLoadingCoverLetter = false
        @State private var resumeUploaded = false
        @Binding var showHomeView: Bool
        private var allSectionsLoaded: Bool {
            !isLoadingAboutMe && !isLoadingExperience && !isLoadingEducation && !isLoadingSkills && !isLoadingCourses && !isLoadingCoverLetter
        }
        var body: some View {
            ScrollView {
                VStack(spacing: 15) {
                    VStack(spacing: 3) {
                        Image(systemName: "person")
                            .font(.system(size: 90))

                        VStack(spacing: 3) {
                            Text("Andrew Jowe")
                                .font(.custom(titleFontName, size: titleFontSize))
                                .foregroundStyle(titleColor)
                            
                            Button("Upload Resume") {
                                showDocumentPicker = true
                            }
                            .font(.custom(bodyFontName, size: bodyFontSize))
                            .padding()
                            .background(titleColor)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .sheet(isPresented: $showDocumentPicker) {
                                DocumentPicker { url in
                                    resumeURL = url
                                    resumeUploaded = true // Mark as uploaded
                                    isLoadingAboutMe = true
                                    // Set loading state for each section with different delays
                                    isLoadingAboutMe = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                        isLoadingAboutMe = false
                                    }

                                    isLoadingExperience = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                        isLoadingExperience = false
                                    }

                                    isLoadingEducation = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                        isLoadingEducation = false
                                    }

                                    isLoadingSkills = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                                        isLoadingSkills = false
                                    }

                                    isLoadingCourses = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                        isLoadingCourses = false
                                    }
                                    isLoadingCoverLetter = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                        isLoadingCoverLetter = false
                                    }
                                }
                                if resumeUploaded {
                                    SectionView(title: "About Me", isLoading: $isLoadingAboutMe)
                                    SectionView(title: "Experience", isLoading: $isLoadingExperience)
                                    SectionView(title: "Education", isLoading: $isLoadingEducation)
                                    SectionView(title: "Skills", isLoading: $isLoadingSkills)
                                    SectionView(title: "Courses", isLoading: $isLoadingCourses)
                                    SectionView(title: "Cover Letter", isLoading: $isLoadingCoverLetter)
                                }

                                
                            }
                        }
                    }

                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("About Me")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if resumeUploaded {
                            if isLoadingAboutMe {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Text("Andrew Jowe is an accomplished Data Scientist and Software Developer with a dual B.S. in Computer Science and Statistics from the University of California, Davis, boasting a 3.98 GPA. His experience spans AI/ML development, full-stack web development, and data analysis, with notable projects including a food planner app and a movie-sharing website. Andrew has a proven track record in business, generating substantial revenue as a sole proprietor, and excels in technical problem-solving and innovation. He is proficient in a variety of programming languages and frameworks, with a strong focus on creating efficient, user-centric solutions. Andrew's diverse skill set and analytical prowess make him a valuable asset to any team, driving forward technological and business solutions.") // Show after loading completes
                                    .font(.custom(bodyFontName, size: bodyFontSize))
                                    .foregroundStyle(bodyColor)
                            }
                        }
                    }
                    
                    VStack(spacing: 3) {
                        Text("Experience")
                            .font(.custom(subtitleFontName, size: subtitleFontSize))
                            .foregroundStyle(subtitleColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if resumeUploaded {
                            if isLoadingExperience {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                VStack() {
                                    HStack(spacing: 3) {
                                        Text("Data Scientist and Software Developer")
                                            .font(.custom(subtitleFontName, size: 14))
                                            .foregroundStyle(bodyColor)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Google Student Developer Club")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Nov. 2023 – Present")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                VStack() {
                                    HStack(spacing: 3) {
                                        Text("Platform Team Software Developer")
                                            .font(.custom(subtitleFontName, size: 14))
                                            .foregroundStyle(bodyColor)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("#include")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Nov. 2023 – Present")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                VStack() {
                                    HStack(spacing: 3) {
                                        Text("Data Scientist")
                                            .font(.custom(subtitleFontName, size: 14))
                                            .foregroundStyle(bodyColor)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("AI Student Collective")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Oct. 2023")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 3) {
                        Text("Education")
                            .font(.custom(subtitleFontName, size: subtitleFontSize))
                            .foregroundStyle(subtitleColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if resumeUploaded {
                            if isLoadingEducation {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                VStack() {
                                    HStack(spacing: 3) {
                                        Text("University of California, Davis")
                                            .font(.custom(subtitleFontName, size: 14))
                                            .foregroundStyle(bodyColor)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Bachelor of Science, Computer Science")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Bachelor of Science, Statistics")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Sep 2021 - Jun 2025")
                                        .font(.custom(bodyFontName, size: bodyFontSize))
                                        .foregroundStyle(bodyColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                            }
                        }
                    }
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Skills")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        if resumeUploaded {
                            if isLoadingSkills {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: 5, verticalSpacing: 5) {
                                    ForEach(skillsArray, id: \.self) { skill in
                                        Text(skill)
                                            .font(.custom(bodyFontName, size: bodyFontSize))
                                            .padding(.vertical, 2)
                                            .padding(.horizontal, 10)
                                            .foregroundStyle(.white)
                                            .background(titleColor)
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Courses")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        if resumeUploaded {
                            if isLoadingCourses {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: 5, verticalSpacing: 5) {
                                    ForEach(coursesArray, id: \.self) { course in
                                        Text(course)
                                            .font(.custom(bodyFontName, size: bodyFontSize))
                                            .padding(.vertical, 2)
                                            .padding(.horizontal, 10)
                                            .foregroundStyle(.white)
                                            .background(titleColor)
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Cover Letter")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if resumeUploaded {
                            if isLoadingCoverLetter {
                                ProgressView() // Show loading indicator after resume is uploaded
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Text("I am Andrew Jowe, a computer science and statistics graduate from the University of California, Davis, with a strong background in AI/ML and software development. My experience ranges from developing AI-driven applications at the Google Student Developer Club to engineering full-stack solutions at #include, showcasing my proficiency in a variety of programming languages and frameworks. My entrepreneurial stint, generating substantial revenue and profit, has sharpened my business acumen and market understanding. I have successfully executed projects that demonstrate my ability to deliver end-to-end software solutions, including a notable AI project with a 95% success rate in stroke prediction. My technical skill set is complemented by a solid foundation in machine learning, statistical modeling, and algorithm design, making me a well-rounded candidate for your team. I am excited about the opportunity to contribute to your company’s success, leveraging my technical expertise and innovative approach to solve complex problems.") // Show after loading completes
                                    .font(.custom(bodyFontName, size: bodyFontSize))
                                    .foregroundStyle(bodyColor)
                            }
                        }
                    }
                    Spacer()
                    if resumeUploaded && allSectionsLoaded {
                                       Button("Continue") {
                                           showHomeView = true
                                       }
                                        .padding()
                                        .background(Color.indigo)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(30)
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            }
            
        }
    }

struct ContentViewDemo: View {
    @State private var showHomeView = false

    var body: some View {
        if showHomeView {
            OcrView()
        } else {
            StudentViewDemo(showHomeView: $showHomeView)
        }
    }
}

    struct StudentViewDemo_Preview: PreviewProvider {
        static var previews: some View {
            ContentViewDemo()
        }
    }
