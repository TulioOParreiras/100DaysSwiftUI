//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Usemobile on 16/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI
import UserNotifications

import CodeScanner

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingSheet = false
    @State private var isShowingScanner = false
    
    @State private var selectedSort: SortTypes = .name
    
    enum FilterType {
        case none, contacted, uncontacted
        
        var title: String {
            switch self {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted people"
            case .uncontacted:
                return "Uncontacted people"
            }
        }
    }
    
    enum SortTypes: String, CaseIterable {
        case name, date
    }
    
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var sortedProspects: [Prospect] {
        switch self.selectedSort {
        case .name:
            return self.filteredProspects.sorted(by: { $0.name < $1.name })
        case .date:
            return self.filteredProspects.sorted(by: { $0.date < $1.date })
        }
    }
    
    let datas: [String] = ["Paul Hudson\npaul@hackingwithswift.com",
    "Tulio Parreiras\ntulio@usemobile.xyz",
    "Jose Fernando\njose@email.com",
    "Juan Carlos\njuan@email.com",
    "Daniel\ndaniel@gmail.com"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: prospect.isContacted ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                    
                }
            }
                .navigationBarTitle(self.filter.title)
            .navigationBarItems(leading: Button(action: {
                self.isShowingSheet = true
            }) {
                Image(systemName: "arrow.up.arrow.down.circle")
                Text(self.selectedSort.rawValue.capitalized)
                }, trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.datas.randomElement() ?? "", completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSheet) {
                ActionSheet(title: Text("Sort"), buttons: SortTypes.allCases.compactMap({ sort in
                    ActionSheet.Button.default(Text("Sort by \(sort.rawValue.capitalized)")) {
                        self.sort(by: sort)
                    }
                    
                }))
            }
        }
    }
    
    func sort(by type: SortTypes) {
        self.selectedSort = type
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
       switch result {
       case .success(let code):
           let details = code.components(separatedBy: "\n")
           guard details.count == 2 else { return }

           let person = Prospect()
           person.name = details[0]
           person.emailAddress = details[1]

           self.prospects.add(person)
       case .failure(let error):
           print("Scanning failed: \(error)")
       }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }

}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
