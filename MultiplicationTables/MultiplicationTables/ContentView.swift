//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Usemobile on 31/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentMultiplicationTable: Int = 1
    @State var selectedQuestions: Int = 0
    @State var gameBegan: Bool = false
    @State var questions: [Int] = []
    
    let questionsArray: [Int] = [3, 6, 9, 12]
    
    var numberOfQuestions: Int {
        return self.questionsArray[self.selectedQuestions]
    }
    
    var body: some View {
        NavigationView {
            Group {
                if self.gameBegan {
                    GameView(multiplicationTable: self.currentMultiplicationTable, numberOfQuestions: self.numberOfQuestions, questions: self.questions, gameFinished: self.finishGame)
                    
                } else {
                    Form {
                        Stepper(value: $currentMultiplicationTable, in: 1...12, step: 1) {
                            Text("Pick your table: \(currentMultiplicationTable)")
                        }
                        
                        Section(header: Text("Select the number of questions").font(.headline)) {
                            Picker("Test", selection: self.$selectedQuestions) {
                                ForEach(0 ..< self.questionsArray.count) {
                                    Text("\(self.questionsArray[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Button(action: startGame) {
                            Text("Start!")
                        }
                        .frame(alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Multiplication Tales")
        }
    }
    
    func generateRandomQuestions() {
        for _ in 1 ... self.numberOfQuestions {
            var randomNumber = Int.random(in: 1...12)
            repeat {
                randomNumber = Int.random(in: 1...12)
            } while self.questions.contains(randomNumber)
            self.questions.append(randomNumber)
        }
        print("Questions: ", self.questions)
    }
    
    func startGame() {
        self.generateRandomQuestions()
        self.gameBegan = true
    }
    
    func finishGame() {
        self.currentMultiplicationTable = 1
        self.selectedQuestions = 0
        self.gameBegan = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameView: View {
    
    var multiplicationTable: Int
    var numberOfQuestions: Int
    var questions: [Int]
    var gameFinished: (() -> Void)
    
    @State var currentQuestion: Int = 0
    @State var gameHasFinished: Bool = false
    @State var score = 0
    @State var answer = ""
    
    var body: some View {
        Form {
            Text("How much is \(self.multiplicationTable) x \(self.questions[self.currentQuestion])")
            TextField("Type your answer here", text: self.$answer)
                .keyboardType(.numberPad)
            Button(action: self.typeAnswer) {
                Text("Confirm")
            }
        }
        .alert(isPresented: $gameHasFinished, content: {
            Alert(title: Text("Table \(self.multiplicationTable) finished"),
                  message: Text("Your score is: \(self.score)/\(self.numberOfQuestions)"),
                  dismissButton: Alert.Button.default(Text("OK"), action: gameFinished))
            
        })
    }
    
    func typeAnswer() {
        let correctAnswer = self.multiplicationTable * self.questions[self.currentQuestion]
        let isCorrect = correctAnswer == (Int(self.answer) ?? 0)
        if isCorrect {
            self.score += 1
        }
        self.answer = ""
        if self.currentQuestion < self.numberOfQuestions - 1 {
            self.currentQuestion += 1
        } else {
            self.gameHasFinished = true
        }
    }
    
    
}
