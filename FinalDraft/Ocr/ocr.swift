import SwiftUI
import VisionKit

struct OcrView: View {
    @State private var startScanning = false
    @State private var scanText = ""
    @State private var useDataScanner = false
    @State private var navigateToProfessorView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                DataScanner(startScanning: $startScanning, scanText: $scanText)
                    .frame(height: 400)
                
                Text(scanText)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                    .background(in: Rectangle())
                    .backgroundStyle(Color(uiColor: .systemGray6))
                
            }
            
            NavigationLink(destination: ProfessorView(), isActive: $navigateToProfessorView) {
                EmptyView()
            }
            .onChange(of: scanText) { newValue in
                if !newValue.isEmpty {
                    navigateToProfessorView = true // Trigger navigation
                }
            }
            .task {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    startScanning.toggle()
                }
            }
            TabBar()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct ProfessorView: View {
    @State private var navigateToResearchView = false

    var body: some View {
        NavigationView { // Ensure there is a NavigationView
            VStack {
                Image("Sam King Pic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 150)

                Text("Professor Sam King")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.orange)
                    .padding()
                Text("My research focus is on technology to manage Type 1 Diabetes...")
                    .font(.system(size: 18, weight: .thin, design: .serif))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding()

                Button("Available Research Positions!") {
                    navigateToResearchView = true
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 60)
                .background(Color.indigo)
                .cornerRadius(15.0)

                NavigationLink("", destination: SamKingView(), isActive: $navigateToResearchView)
            }
        }
    }
}


#Preview {
    OcrView()
}
