//
//  ActivityDetailView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.largeTitle.bold())
                Text(activity.description)
            }
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity:
                            Activity(
                                title: "Running",
                                description: "Run 5 km everyday and go to the gym at least 4 times in a week",
                                completionCount: 5
                            ))
    }
}
