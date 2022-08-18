//
//  AnimationViewP.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 1/8/2022.
//

import SwiftUI

struct AnimationViewP: View {
    @State private var animationAmount = 1.0
    @State private var isEnabled = false
    
    var body: some View {
        VStack(spacing: 200) {
            Button("Tap Me") {
//                animationAmount = animationAmount >= 5 ? 1 : animationAmount + 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(.easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                               value: animationAmount)
            )
            
            Button("Tap Me") {
                isEnabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(isEnabled ? .blue : .red)
            .animation(.default, value: isEnabled)
            .foregroundColor(.white)
            .font(.title)
            .clipShape(RoundedRectangle(cornerRadius: isEnabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: isEnabled)
            
            
        }
        .padding(50)
        .onAppear {
            animationAmount = 2
        }
        
    }
}

struct AnimationViewP_Previews: PreviewProvider {
    static var previews: some View {
        AnimationViewP()
    }
}
