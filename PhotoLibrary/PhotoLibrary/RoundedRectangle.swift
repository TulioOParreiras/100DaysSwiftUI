//
//  RoundedRectangle.swift
//  PhotoLibrary
//
//  Created by Usemobile on 10/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI
import UIKit

struct RoundedRectangle: Shape {
    
    var radius: CGFloat
    
    init(radius: CGFloat = 20) {
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: radius))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: 20))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 270), clockwise: true)
        path.addLine(to: CGPoint(x: 20, y: 0))
        path.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: radius))
        
        return path
    }
}
