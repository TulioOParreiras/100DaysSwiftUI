//
//  DetailView.swift
//  PhotoLibrary
//
//  Created by Usemobile on 10/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailView: View {
    
    var photo: Photo
    
    @State var isShowingMap = false
    @State var isOn = false
    
    var body: some View {
        GeometryReader { geometry in

            ScrollView {
                Image(uiImage: self.photo.image)
                    .resizable()
                    .frame(maxWidth: geometry.size.width * 0.8, maxHeight: geometry.size.width * 0.8)
                    .clipShape(RoundedRectangle())
                    .aspectRatio(contentMode: .fill)
                
                if self.photo.location != nil {
                    HStack {
                        Toggle(isOn: self.$isOn) {
                            Text("Shows map: ")
                        }
                    }
                    .padding()
                    if self.isOn {
                        MapView(photo: self.photo)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.photo.name))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: Photo(name: "Test", data: Data(), latitude: 0, longitude: 0))
    }
}
