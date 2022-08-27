//
//  AccessibilityMainView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 26/8/2022.
//

import SwiftUI

struct AccessibilityMainView: View {
    var body: some View {
        Image(systemName: "globe")
            .resizable()
            .frame(width: 120, height: 120)
            .accessibilityLabel("Globe")
            .accessibilityHint("Empty globe of black color in the middle of the screen")
    }
}

struct AccessibilityMainView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityMainView()
    }
}
