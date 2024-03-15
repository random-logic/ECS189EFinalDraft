import SwiftUI
import WrappingStack

struct StaticStudentViewDemo: View {
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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    VStack(spacing: 3) {
                        Image(systemName: "person")
                            .font(.system(size: 90))
                        
                        VStack(spacing: 3) {
                            Text("Andrew Jowe")
                                .font(.custom(titleFontName, size: titleFontSize))
                                .foregroundStyle(titleColor)
                            
                        }
                    }
                    
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("About Me")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Andrew Jowe is an accomplished Data Scientist and Software Developer with a dual B.S. in Computer Science and Statistics from the University of California, Davis, boasting a 3.98 GPA. His experience spans AI/ML development, full-stack web development, and data analysis, with notable projects including a food planner app and a movie-sharing website. Andrew has a proven track record in business, generating substantial revenue as a sole proprietor, and excels in technical problem-solving and innovation. He is proficient in a variety of programming languages and frameworks, with a strong focus on creating efficient, user-centric solutions. Andrew's diverse skill set and analytical prowess make him a valuable asset to any team, driving forward technological and business solutions.")
                            .font(.custom(bodyFontName, size: bodyFontSize))
                            .foregroundStyle(bodyColor)
                    }
                    
                    VStack(spacing: 3) {
                        Text("Experience")
                            .font(.custom(subtitleFontName, size: subtitleFontSize))
                            .foregroundStyle(subtitleColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    
                    VStack(spacing: 3) {
                        Text("Education")
                            .font(.custom(subtitleFontName, size: subtitleFontSize))
                            .foregroundStyle(subtitleColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Skills")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Courses")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    VStack(spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Cover Letter")
                                .font(.custom(subtitleFontName, size: subtitleFontSize))
                                .foregroundStyle(subtitleColor)
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("I am Andrew Jowe, a computer science and statistics graduate from the University of California, Davis, with a strong background in AI/ML and software development. My experience ranges from developing AI-driven applications at the Google Student Developer Club to engineering full-stack solutions at #include, showcasing my proficiency in a variety of programming languages and frameworks. My entrepreneurial stint, generating substantial revenue and profit, has sharpened my business acumen and market understanding. I have successfully executed projects that demonstrate my ability to deliver end-to-end software solutions, including a notable AI project with a 95% success rate in stroke prediction. My technical skill set is complemented by a solid foundation in machine learning, statistical modeling, and algorithm design, making me a well-rounded candidate for your team. I am excited about the opportunity to contribute to your company’s success, leveraging my technical expertise and innovative approach to solve complex problems.")
                            .font(.custom(bodyFontName, size: bodyFontSize))
                            .foregroundStyle(bodyColor)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(30)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                
            }
            TabBar()
        }
    }
}

#Preview {
    StaticStudentViewDemo()
}
