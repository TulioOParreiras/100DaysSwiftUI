//
//  ContentView.swift
//  Instafilter
//
//  Created by Usemobile on 27/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var processedImage: UIImage?
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
        },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                        .resizable()
                        .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        .actionSheet(isPresented: $showingFilterSheet, content: {
            ActionSheet(title: Text("Select a filter"), buttons: [
                .default(Text("Crystalize")) {
                    self.setFilter(CIFilter.crystallize())
                },
                .default(Text("Edges")) {
                    self.setFilter(CIFilter.edges())
                },
                .default(Text("Gaussian Blur")) {
                    self.setFilter(CIFilter.gaussianBlur())
                },
                .default(Text("Pixellate")) {
                    self.setFilter(CIFilter.pixellate())
                },
                .default(Text("Sepia Tone")) {
                    self.setFilter(CIFilter.sepiaTone())
                },
                .default(Text("Unsharp Mask")) {
                    self.setFilter(CIFilter.unsharpMask())
                },
                .default(Text("Vignette")) {
                    self.setFilter(CIFilter.vignette())
                },
                .cancel()
            ])
        })
        }
    }
    
    func loadImage() {
        guard let inputImage = self.inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            self.currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            self.currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            self.currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cmimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cmimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        self.currentFilter = filter
        loadImage()
    }
    
}


//class ImageSaver: NSObject {
//    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
//    }
//
//    @objc func saveError(_ image: UIImage,
//                         didFinishSavingWithError error: Error?,
//                         contextInfo: UnsafeRawPointer) {
//        print("Save finished")
//    }
//}
//
//struct ContentView: View {
//
//    @State private var showingImagePikcer = false
//    @State private var inputImage: UIImage?
//
//    @State private var image: Image?
//
//    @State private var showingActionSheet = false
//    @State private var backgroundColor = Color.white
//
//    var body: some View {
//        VStack {
//            image?
//            .resizable()
//            .scaledToFit()
//
//            Button("Select Image") {
//                self.showingImagePikcer = true
//            }
//        }
//        .sheet(isPresented: $showingImagePikcer, onDismiss: loadImage) {
//            ImagePicker(image: self.$inputImage)
//        }
////        .onAppear(perform: loadImage)
//
////        Text("Hello World")
////            .frame(width: 300, height: 300)
////            .background(self.backgroundColor)
////            .onTapGesture {
////                self.showingActionSheet = true
////            }
////            .actionSheet(isPresented: self.$showingActionSheet) {
////                ActionSheet(title: Text("Change background"),
////                        message: Text("Select a new color"),
////                        buttons: [
////                        .default(Text("Red"), action: { self.backgroundColor = .red }),
////                        .default(Text("Green"), action: { self.backgroundColor = .green }),
////                        .default(Text("Blue"), action: { self.backgroundColor = .blue }),
////                        .cancel()
////                ])
////            }
//    }
//
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//
//        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: inputImage)
//    }
//
//    enum ImageFilters {
//        case sepia
//        case pixellate
//        case crystallize
//        case twirlDistortion
//    }
//
////    func loadImage() {
////        guard let inputImage = UIImage(named: "Example") else { return }
////        let beginImage = CIImage(image: inputImage)
////
////        let context = CIContext()
////
////        let imageFilter: ImageFilters = .crystallize
////        let currentFilter = self.getFilter(for: imageFilter, with: beginImage, with: inputImage)
////
////        guard let outputImage = currentFilter.outputImage else { return }
////
////        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
////            let uiImage = UIImage(cgImage: cgimg)
////            image = Image(uiImage: uiImage)
////        }
////    }
//
//    func getFilter(for imageFilter: ImageFilters, with beginImage: CIImage?, with inputImage: UIImage) -> CIFilter {
//        switch imageFilter {
//        case .twirlDistortion:
//            guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { fallthrough }
//            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//            currentFilter.setValue(500, forKey: kCIInputRadiusKey)
//            currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
//            return currentFilter
//        case .sepia:
//            let currentFilter = CIFilter.sepiaTone()
//            currentFilter.inputImage = beginImage
//            currentFilter.intensity = 1
//            return currentFilter
//        case .pixellate:
//            let currentFilter = CIFilter.pixellate()
//            currentFilter.inputImage = beginImage
//            currentFilter.scale = 10
//            return currentFilter
//        case .crystallize:
//            let currentFilter = CIFilter.crystallize()
//            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//            currentFilter.radius = 10
//            return currentFilter
//        }
//    }
//
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
