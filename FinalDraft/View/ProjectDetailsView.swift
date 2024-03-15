import SwiftUI

struct KingDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("King Project")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            
            Text("Description:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Bullet point 1\n• Bullet point 2\n• Bullet point 3")
            
            Text("Qualifications:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Qualification 1\n• Qualification 2\n• Qualification 3")
            
            Spacer()
            
            NavigationLink(destination: AppliedScreen()) {
                HStack {
                    Spacer()
                    Text("Apply Now")
                    Spacer()
                }
            }
        }
        .padding()
        .contentShape(Rectangle())
    }
}

struct ButnerDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Butner Project")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            
            Text("Description:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Bullet point 1\n• Bullet point 2\n• Bullet point 3")
            
            Text("Qualifications:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Qualification 1\n• Qualification 2\n• Qualification 3")
            
            Spacer()
            
            NavigationLink(destination: AppliedScreen()) {
                HStack {
                    Spacer()
                    Text("Apply Now")
                    Spacer()
                }
            }
        }
        .padding()
        .contentShape(Rectangle())
    }
}

struct FridDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Frid Project")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            
            Text("Description:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Bullet point 1\n• Bullet point 2\n• Bullet point 3")
            
            Text("Qualifications:")
                .font(.headline)
                .fontWeight(.bold)
            Text("• Qualification 1\n• Qualification 2\n• Qualification 3")
            
            Spacer()
            
            NavigationLink(destination: AppliedScreen()) {
                HStack {
                    Spacer()
                    Text("Apply Now")
                    Spacer()
                }
            }
        }
        .padding()
        .contentShape(Rectangle())
    }
}

struct KingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        KingDetailView()
    }
}
