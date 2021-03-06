//
//  ContentView.swift
//  Flashzilla
//
//  Created by Usemobile on 18/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var timeRemaining = 100
    @State private var cards = [Card]()
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                            .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()

                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
            
        }
        .onAppear(perform: resetCards)
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
                EditCards()
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if !self.cards.isEmpty {
                self.isActive = true
            }
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}


//struct ContentView: View {
//
//    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
//
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale: CGFloat = 1
//
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
//
//    @State private var engine: CHHapticEngine?
//
//    // how far the circle has been dragged
//    @State private var offset = CGSize.zero
//
//    // where it is currently being dragged or not
//    @State private var isDragging = false
//
//    var body: some View {
//        Text("Hello, World!")
//            .padding()
//            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
//            .foregroundColor(Color.white)
//            .clipShape(Capsule())
//
////        Text("Hello, World!")
////        .scaleEffect(scale)
////        .onTapGesture {
////            self.withOptionalAnimation {
////                self.scale *= 1.5
////            }
////        }
//
////        HStack {
////            if differentiateWithoutColor {
////                Image(systemName: "checkmark.circle")
////            }
////
////            Text("Success")
////        }
////        .padding()
////        .background(differentiateWithoutColor ? Color.black : Color.green)
////        .foregroundColor(Color.white)
////        .clipShape(Capsule())
//
////        Text("Hello, World!")
//////        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//////            print("Moving to the background!")
//////        }
////        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
////            print("User took a screenshot!")
////        }
//
////        Text("Hello, World!")
////            .onReceive(timer) { time in
////                if self.counter == 5 {
////                    self.timer.upstream.connect().cancel()
////                } else {
////                    print("The time is now \(time)")
////                }
////
////                self.counter += 1
////            }
//
////        VStack {
////            Text("Hello")
////            Spacer().frame(height: 100)
////            Text("World")
////        }
////        .contentShape(Rectangle())
////        .onTapGesture {
////            print("VStack tapped!")
////        }
//
////        ZStack {
////            Rectangle()
////                .fill(Color.blue)
////                .frame(width: 300, height: 300)
////                .onTapGesture {
////                    print("Rectangle tapped!")
////                }
////
////            Circle()
////                .fill(Color.red)
////                .frame(width: 300, height: 300)
////                .contentShape(Rectangle())
////                .onTapGesture {
////                    print("Circle tapped!")
////                }
//////                .allowsHitTesting(false)
////        }
//
////        Text("Hello, World!")
////        .onAppear(perform: prepareHaptics)
////        .onTapGesture(perform: complexSuccess)
//
////        // a drag gesture that updates offset and isDragging as it moves around
////        let dragGesture = DragGesture()
////            .onChanged { value in self.offset = value.translation }
////            .onEnded { _ in
////                withAnimation {
////                    self.offset = .zero
////                    self.isDragging = false
////                }
////            }
////
////        // a long press gesture that enables isDragging
////        let tapGesture = LongPressGesture()
////            .onEnded { value in
////                withAnimation {
////                    self.isDragging = true
////                }
////            }
////
////        // a combined gesture that forces the user to long press then drag
////        let combined = tapGesture.sequenced(before: dragGesture)
////
////        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
////        return Circle()
////            .fill(Color.red)
////            .frame(width: 64, height: 64)
////            .scaleEffect(isDragging ? 1.5 : 1)
////            .offset(offset)
////            .gesture(combined)
//    }
//
//    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
//        if UIAccessibility.isReduceMotionEnabled {
//            return try body()
//        } else {
//            return try withAnimation(animation, body)
//        }
//    }
//
//    func simpleSuccess() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//    }
//
//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        do {
//            self.engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//
//    func complexSuccess() {
//        // make sure that the device supports haptics
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        var events = [CHHapticEvent]()
//
//        // create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//
////         for i in stride(from: 0, to: 1, by: 0.1) {
////             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
////             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
////             let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
////             events.append(event)
////         }
////
////         for i in stride(from: 0, to: 1, by: 0.1) {
////             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
////             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
////             let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
////             events.append(event)
////         }
//
//        events.append(event)
//
//        // convert those events into a pattern and play it immediately
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
