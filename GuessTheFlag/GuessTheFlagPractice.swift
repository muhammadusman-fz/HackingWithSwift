//
//  GuessTheFlagPractice.swift
//  WeSplit-Project-1
//
//  Created by Muhammad Usman on 26/7/22.
//

import SwiftUI
/**
 To create custom modifiers:
    1. Create a struct that confirms to ViewModifier protocol and have body func
    2. We can use modifier directly with our views like .modifer(Title), but it's good idea to
        create an extension function of view
 */
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .padding(50)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(color: .green, radius: 5, x: 5, y: 5)
    }
}

struct GuessTheFlagPractice: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .mint]), startPoint: .top, endPoint: .bottom)
            
            Text("MUHAMMAD (SAW)")
                .titleStyle()
                
        }
        .ignoresSafeArea()
    }
}

struct GuessTheFlagPractice_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagPractice()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
