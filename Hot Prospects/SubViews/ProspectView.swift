//
//  ProspectView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 2/9/2022.
//

import SwiftUI
import UserNotifications

struct ProspectView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    @EnvironmentObject var prospects: Prospects
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.connected }
        case .uncontacted:
            return prospects.people.filter { !$0.connected }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundColor(.secondary)
                        }
                        
                        if prospect.connected == true {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    .swipeActions {
                        if prospect.connected {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                 Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                 Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotifications(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addNotifications(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
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

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProspectView(filter: .none)
                .environmentObject(Prospects())
        }
    }
}
