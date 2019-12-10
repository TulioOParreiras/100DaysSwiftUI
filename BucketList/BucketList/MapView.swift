//
//  MapView.swift
//  BucketList
//
//  Created by Usemobile on 04/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    var photo: Photo
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {


            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
//        mapView.isUserInteractionEnabled = false
        mapView.delegate = context.coordinator
        if let location = self.photo.location {
            mapView.centerCoordinate = location
        }
        mapView.cameraZoomRange = MKMapView.CameraZoomRange.init(maxCenterCoordinateDistance: 10000)
//        mapView.setCameraZoomRange(MKMapView.CameraZoomRange.init(maxCenterCoordinateDistance: 10000), animated: false)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let location = self.photo.location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            uiView.addAnnotation(annotation)
        }
//        if annotations.count != uiView.annotations.count {
//            uiView.removeAnnotations(uiView.annotations)
//            uiView.addAnnotations(self.annotations)
//        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
//    }
//}
