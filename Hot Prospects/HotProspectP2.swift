//
//  HotProspectP2.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 1/9/2022.
//

import SamplePackage
import SwiftUI
import UserNotifications

/// 5. Creating context menus
/// 6. Swipe to delete
/// 7. Showing notification
/// 8. Adding packgage

struct HotProspectP2: View {
    
    @State private var backgroundColor = Color.gray.opacity(0.5)
    
    @State private var permissionGranted = Color.blue
    
    let possibleNumbers = Array(1...60)
    var result: String {
        let selected = possibleNumbers.random(4).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                /// 5. Creating context menus
                Text("Change Color")
                    .padding()
                    .contextMenu {
                        Button(role: .destructive) {
                            backgroundColor = .red
                        } label: {
                            Label("Red", systemImage: "checkmark.circle.fill")
                        }
                        
                        Button {
                            backgroundColor = .brown
                        } label: {
                            Label("Brown", systemImage: "checkmark.circle.fill")
                        }
                        
                        Button {
                            backgroundColor = .green
                        } label: {
                            Label("Green", systemImage: "checkmark.circle.fill")
                        }
                    }
                
                /// 8. Using external library
                Text("Lottery numbers are:\n\(result)")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                ///6. Swipe to delete
                
                List {
                    Text("Swipe me")
                        .swipeActions {
                            Button(role: .destructive) {
                                print("Deleting")
                            } label: {
                                Label("Delete", systemImage: "minus")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                print("Pin")
                            } label: {
                                Label("Pin", systemImage: "pin")
                            }
                            .tint(.orange)
                        }
                }

                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All Set")
                            permissionGranted = .green
                        } else if error != nil {
                            permissionGranted = .red
                        }
                    }
                }
                .padding(10)
                .background(permissionGranted)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Schedule Permission") {
                    let content = UNMutableNotificationContent()
                    content.title = "Get a haircut please"
                    content.body = "Dog is staring at you"
                    content.sound = .default
                    
                    // Show after 5 seconds
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                .padding(10)
                .background(.brown)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            
        }
        .padding()
        .background(backgroundColor)
    }
}

struct HotProspectP2_Previews: PreviewProvider {
    static var previews: some View {
        HotProspectP2()
    }
}
