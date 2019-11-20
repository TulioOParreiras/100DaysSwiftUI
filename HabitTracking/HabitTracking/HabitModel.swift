//
//  HabitModel.swift
//  HabitTracking
//
//  Created by Usemobile on 20/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id: UUID
    var count: Int = 0
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.id = UUID()
    }
    
    mutating func increment() {
        self.count += 1
    }
}

class HabitsList: ObservableObject {
    @Published public private(set) var habits: [Habit] = []
    
    func insertHabit(_ habit: Habit) {
        guard !self.habits.contains(where: { $0.id == habit.id }) else { return }
        self.habits.append(habit)
        self.habits.sort(by: { $0.name < $1.name })
        
        if let data = try? JSONEncoder().encode(self.habits) {
            UserDefaults.standard.set(data, forKey: "HabitData")
        }
    }
    
    init() {
        if let habitData = UserDefaults.standard.data(forKey: "HabitData") {
            do {
                let habits = try JSONDecoder().decode([Habit].self, from: habitData)
                self.habits = habits.sorted(by: { $0.name < $1.name })
            } catch {
                print("Failed to decode data with error: ", error)
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func getRow(for habit: Habit) -> Int {
        return self.habits.firstIndex(where: { $0.id == habit.id }) ?? 0
    }
    
}
