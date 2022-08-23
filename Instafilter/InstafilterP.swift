//
//  InstafilterP.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 19/8/2022.
//

import SwiftUI
///*
///1. Observing state change of property wrappers
///

struct InstafilterP: View {
    @State private var blurAmount = 0.0
    @State private var backgroundColor = Color.cyan
    @State private var showingDialog = false
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Usman")
                .font(.title)
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .colorMultiply(.white)
                .cornerRadius(20)
                .blur(radius: blurAmount)
            
            image?
                .resizable()
                .scaledToFit()
            
            Slider(value: $blurAmount, in: 0...5)
                .padding()
                .onChange(of: blurAmount) { newValue in
                    print("Value is \(newValue)")
                }
            
            Button("Change Background") {
                showingDialog.toggle()
            }
            
            Button("Select Image") {
                showingImagePicker.toggle()
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
            .confirmationDialog("Select Color", isPresented: $showingDialog) {
                Button("Red") { backgroundColor = .red }
                Button("Mint") { backgroundColor = .mint }
                Button("Cyan") { backgroundColor = .cyan }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct InstafilterP_Previews: PreviewProvider {
    static var previews: some View {
        InstafilterP()
    }
}
