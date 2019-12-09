//
//  ContentView.swift
//  PhotoLibrary
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI
import UIKit

struct NameView: View {
    
    @State private var aux_name: String = ""
    @Binding var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {

            TextField("Type the image's name", text: $aux_name)
            Button(action: {
                self.name = self.aux_name
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm")
            }
        }
    }
}

struct ContentView: View {
    
    @State private var photos: [Photo] = []
    @State private var selectedImage: UIImage?
    @State private var showingPicker = false
    @State private var didSelectImage = false
    @State private var imageName: String = ""
    
    var body: some View {
        let pickedImage = Binding<UIImage?>(
            get: {
                self.selectedImage
        },
            set: {
                self.selectedImage = $0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.didSelectImage = true
                }
        }
        )
        let pickedName = Binding<String>(
            get :{
                self.imageName
        },
            set: {
                self.imageName = $0
                self.saveImage()
        })
        let showingSheet = Binding<Bool>(
            get: {
                self.showingPicker || self.didSelectImage
        },
            set: {
                self.showingPicker = $0
                self.didSelectImage = $0
        }
        )
        
        return NavigationView {
            List(photos) { photo in
                HStack {
                    Image(uiImage: photo.image)
                    .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                    Text(photo.name)
                }
            }
            .navigationBarTitle("Photo Library")
            .navigationBarItems(trailing: Button(action: {
                self.showingPicker = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: showingSheet, content: {
            if self.didSelectImage {
                NameView(name: pickedName)
            } else if self.showingPicker {
                ImagePicker(image: pickedImage)
            }
            
        })
//        .sheet(isPresented: $didSelectImage, content: {
//            NameView(name: pickedName)
//        })
    }
    
    func saveImage() {
        guard let image = self.selectedImage, let data = image.jpegData(compressionQuality: 1) else { return }
        let photo = Photo(name: self.imageName, data: data)
        self.photos.append(photo)
        self.selectedImage = nil
        self.imageName = ""
        self.didSelectImage = false
        self.showingPicker = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
