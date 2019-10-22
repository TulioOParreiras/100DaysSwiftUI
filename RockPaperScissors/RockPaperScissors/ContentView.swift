//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Usemobile on 22/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    enum ActiveAlert {
        case round, game
    }
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var selectedMove: Int = 0
    @State private var systemMove: Int = 0
    @State private var shouldWin: Bool = false
    
    @State private var currentRound = 0
    
    @State private var roundWinner: String = "Round winner: Player"
    @State private var playerPoints = 0
    
    @State private var showingAlert = false
    @State private var currentAlert: ActiveAlert = .round
    
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.moves.count) { number in
                Button(action: {
                    self.moveSelected(number)
                }) {
                    Text(self.moves[number])
                }
            }
        }
        .alert(isPresented: self.$showingAlert) { () -> Alert in
            switch self.currentAlert {
            case .round:
                return Alert(title: Text("Round \(self.currentRound)"),
                      message: Text("""
                        System move: \(self.moves[self.systemMove])
                        Player move: \(self.moves[self.selectedMove])
                        Sould win: \(self.shouldWin ? "true" : "false")
                        
                        \(self.roundWinner)
                        """),
                      dismissButton: .default(Text("Continue")))
            case .game:
                return Alert(title: Text("Best of 10 result"), message: Text("Player score: \(self.playerPoints)"), dismissButton: .default(Text("Continue")) {
                    self.playerPoints = 0
                    self.currentRound = 0
                    })
            }
        }
    }
    
    func beginRound() {
        self.currentRound += 1
        self.systemMove = Int.random(in: 0 ..< self.moves.count)
        self.shouldWin = Bool.random()
        print("System move: \(self.moves[self.systemMove])")
    }
    
    func moveSelected(_ number: Int) {
        self.beginRound()
        print("Player move: \(self.moves[number])")
        self.selectedMove = number
        let moveDif = number - self.systemMove
        let adjustedValue = moveDif < 0 ? moveDif + 3 : moveDif

        switch adjustedValue {
        case 0:
            self.roundWinner = "Round result: Tie"
        default:
            let playerWon: Bool = self.shouldWin ? adjustedValue == 1 : adjustedValue == 2
            self.roundWinner = "Round result: " + (playerWon ? "Player" : "System") + " wins"
            if playerWon {
                self.playerPoints += 1
            } else {
                self.playerPoints -= 1
            }
        }
        
        self.currentAlert = self.currentRound == 10 ? .game : .round
        self.showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
