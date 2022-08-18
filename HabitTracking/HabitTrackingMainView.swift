//
//  HabitTrackingMainView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 3/8/2022.
//

import SwiftUI

struct HabitTrackingMainView: View {
    @State private var showingAddActivity = false
    @StateObject private var activity = Activities()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activity.activities) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.headline).bold()
                                
                                Text("\(activity.completionCount)")
                                    .foregroundColor(.black.opacity(0.5))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Track Me")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddActivity.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activity: activity)
            }
        }
    }
}

struct HabitTrackingMainView_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackingMainView()
    }
}
