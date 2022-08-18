//
//  BookwormPracticeView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 9/8/2022.
//

/**
    1. Use of @Binding
    2. Use of multine line text input TextEditor
 */

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColor = [Color.red, Color.yellow]
    var offColor = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColor : offColor, startPoint: .top, endPoint: .bottom)
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 0.5)
    }
}


struct BookwormPracticeView: View {
    @State private var rememberMe = false
    
    @AppStorage("notes") private var notes = ""
//    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                PushButton(title: "Remember Me", isOn: $rememberMe)
                Text(rememberMe ? "On" : "Off")
            }
            
            VStack {
                TextEditor(text: $notes)
                    .colorMultiply(.gray)
                    .padding()
                    .cornerRadius(5)
            }
        }
    }
}

struct BookwormPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        BookwormPracticeView()
    }
}
