//
//
//import SwiftUI
//import Vision
//
//// Function to perform text recognition
//func performTextRecognition(on image: UIImage, completion: @escaping ([String]) -> Void) {
//    guard let cgImage = image.cgImage else {
//        completion([])
//        return
//    }
//
//    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//    let request = VNRecognizeTextRequest { request, error in
//        guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
//            print("Unable to perform the requests: \(String(describing: error)).")
//            completion([])
//            return
//        }
//        
//        let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
//        completion(recognizedStrings)
//    }
//
//    do {
//        try requestHandler.perform([request])
//    } catch {
//        print("Unable to perform the requests: \(error).")
//        completion([])
//    }
//}
//
//// Main OCR View
//struct alt_ocr: View {
//    @State private var showImagePicker = false
//    @State private var image: UIImage?
//    @State private var recognizedText: [String] = []
//    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary // Default to photo library for wider compatibility
//
//    var body: some View {
//        VStack {
//            // Display the selected image
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            }
//
//            // Display recognized text
//            ForEach(recognizedText, id: \.self) { text in
//                Text(text)
//            }
//
//            // Selection menu for image source
//            Menu("Select Image") {
//                if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                    Button("Use Camera") {
//                        sourceType = .camera
//                        showImagePicker = true
//                    }
//                }
//                Button("Photo Library") {
//                    sourceType = .photoLibrary
//                    showImagePicker = true
//                }
//            }
//        }
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(selectedImage: $image, sourceType: sourceType)
//                .onDisappear {
//                    if let selectedImage = image {
//                        performTextRecognition(on: selectedImage) { strings in
//                            recognizedText = strings
//                        }
//                    }
//                }
//        }
//    }
//}
//
//
//struct alt_ocr_Previews: PreviewProvider {
//    static var previews: some View {
//        alt_ocr()
//    }
//}
//
//
