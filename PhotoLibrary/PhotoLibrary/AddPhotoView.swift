//
//  AddPhotoView.swift
//  PhotoLibrary
//
//  Created by Usemobile on 10/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct AddPhotoView: View {
    
    @Binding var photos: [Photo]
    @State private var name = ""
    @State private var selectedImage: UIImage?
    @State private var showingPicker = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView {

            Section {
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle())
                    .onTapGesture {
                        self.showingPicker = true
                }
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))

            Section {
                TextField("Name", text: $name)
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

            Section {
                Button(action: finish) {
                    Text("Finish")
                }
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
        }
        .sheet(isPresented: $showingPicker, content: {
            ImagePicker(image: self.$selectedImage)
        })
    }
    
    func finish() {
        guard !self.name.isEmpty else { return }
        guard let image = self.selectedImage, let data = image.jpegData(compressionQuality: 1) else { return }
        self.photos.append(Photo(name: self.name, data: data))
        do {
            try self.saveData()
        } catch {
            print("Data save failure: \(error)")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveData() throws {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = path.appendingPathComponent("SavedPhotos")
        
        let data = try JSONEncoder().encode(self.photos)
        try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
    }
}

