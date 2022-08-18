//
//  AddActivityView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import SwiftUI

struct AddActivityView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var completionCount = 0
    
    @ObservedObject var activity: Activities
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("Activity title", text: $title)
                
                TextField("Enter description here", text: $description)
                
                HStack {
                    Text("Completeted: \(completionCount) times")
                    
                    Button("+ 1") {
                        completionCount += 1
                    }
                }
            }
            
            Button {
                let item = Activity(title: title, description: description, completionCount: completionCount)
                activity.activities.insert(item, at: 0)
                dismiss()
            } label: {
                Text("Save")
                    .padding()
                    .foregroundColor(.white)
                    .font(.headline.bold())
                    .frame(width: 200, height: 50)
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
        .padding([.bottom], 5)
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activity: Activities())
    }
}
