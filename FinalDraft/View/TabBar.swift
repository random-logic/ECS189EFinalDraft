import SwiftUI

struct TabBar: View {
    @State private var selectedTab: Int = 0 // State variable to keep track of the selected tab
    @State var graduationCapTapped = false
    @State var cameraTapped = false
    @State var profileTapped = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0.0) {
                Divider()
                HStack {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        .padding()
                        .onTapGesture {
                            profileTapped = true
                        }
                    NavigationLink("", destination: StaticStudentViewDemo(), isActive: $profileTapped)
                    Spacer()
                    
                    Image(systemName: "camera")
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        .padding()
                        .onTapGesture {
                            cameraTapped = true
                        }
                    NavigationLink("", destination: OcrView(), isActive: $cameraTapped)
                    Spacer()
                    
                    Image(systemName: "graduationcap.fill")
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        .padding()
                        .onTapGesture {
                            graduationCapTapped = true
                        }
                    NavigationLink("", destination: ProjectOptionsView(), isActive: $graduationCapTapped)
                    
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 10)
            }
        }
        }
}
