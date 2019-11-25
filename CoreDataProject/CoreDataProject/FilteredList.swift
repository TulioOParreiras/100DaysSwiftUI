//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    enum Predicators: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
    }
    
    var fetchedRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchedRequest.wrappedValue }
    let content: (T) -> Content
    
    var body: some View {
        List(fetchedRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(sortDescriptors: [NSSortDescriptor], filterKey: String, predicate: Predicators, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchedRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
