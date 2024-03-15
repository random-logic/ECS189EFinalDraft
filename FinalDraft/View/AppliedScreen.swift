import SwiftUI

struct AppliedScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
            Text("Application Successful!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Thank you for applying.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
            
            Text("Your resume, cover letter, and all your information has been automatically sent.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    
    }
}

struct AppliedScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppliedScreen()
    }
}
