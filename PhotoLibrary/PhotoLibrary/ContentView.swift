//
//  ContentView.swift
//  PhotoLibrary
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var photos: [Photo] = []
    @State private var showingAddPhoto = false
    
    var body: some View {
        
        return NavigationView {
            List(photos) { photo in
                NavigationLink(destination: DetailView(photo: photo)) {
                    HStack {
                        Image(uiImage: photo.image)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                        Text(photo.name)
                    }
                }
            }
            .navigationBarTitle("Photo Library")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddPhoto = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddPhoto, content: {
            AddPhotoView(photos: self.$photos)
            
        })
            .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = path.appendingPathComponent("SavedPhotos")
        do {
            let data = try Data(contentsOf: fileName)
            self.photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            print("Load data error: \(error)")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
