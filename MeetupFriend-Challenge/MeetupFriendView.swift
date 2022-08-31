//
//  MeetupFriendView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 27/8/2022.
//

import SwiftUI

struct MeetupFriendView: View {
    @State private var showingImageSelection = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
        }
        .sheet(isPresented: $showingImageSelection) {
            PhotoPicker(image: $inputImage)
        }
        .navigationTitle("MeetFriend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    showingImageSelection.toggle()
                } label: {
                    Label("Add Friend", systemImage: "plus")
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
    }
}

struct MeetupFriendView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeetupFriendView()
        }
    }
}
