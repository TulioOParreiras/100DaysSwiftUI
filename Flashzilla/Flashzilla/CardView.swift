//
//  CardView.swift
//  Flashzilla
//
//  Created by Usemobile on 08/01/20.
//  Copyright © 2020 Usemobile. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                    
            )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
            )
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                
                if self.isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
            }
                
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    self.removal?()
                } else {
                    self.offset = .zero
                }
            }
        )
            .onTapGesture {
                self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
