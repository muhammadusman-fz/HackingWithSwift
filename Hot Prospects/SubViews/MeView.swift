//
//  MeView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 2/9/2022.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Muhammad Usman"
    @State private var email = "maaniappdeveloper@gmail.com"
    
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .font(.title)
                .textContentType(.name)
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
            
            Image(uiImage: qrCode)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
                .contextMenu {
                    Button {
                        let image = generateQRCode(for: "\(name)\n\(email)")
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: image)
                    } label: {
                        Label("Save to Photos", systemImage: "square.and.arrow.down")
                    }
                }
        }
        .onAppear(perform: updateCode)
        .onChange(of: name) { _ in updateCode() }
        .onChange(of: email) { _ in updateCode() }
    }
    
    func generateQRCode(for string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(for: "\(name)\n\(email)")
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
