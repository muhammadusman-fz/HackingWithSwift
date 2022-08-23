//
//  InstaFilterMainView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 22/8/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct InstaFilterMainView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingSelectImage = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                
                Text("Tap to select the picture")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onChange(of: inputImage) { _ in
                        loadImage()
                    }
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingSelectImage.toggle()
            }
            
            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity) { _ in
                        applyProcessing()
                    }
            }
            .padding(.vertical)
            
            HStack {
                Button("Change filter") {
                    // change filter
                }
                
                Spacer()
                
                Button("Save", action: save)
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Instafilter")
        .sheet(isPresented: $showingSelectImage) {
            ImagePicker(image: $inputImage)
        }
        
    }
    
    func save() {
        
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimag = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimag)
            image = Image(uiImage: uiImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
}

struct InstaFilterMainView_Previews: PreviewProvider {
    static var previews: some View {
        InstaFilterMainView()
    }
}
