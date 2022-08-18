//
//  CupcakeCornerPractice.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct CupcakeCornerPractice: View {
    @State private var results = [Result]()
    
    @State private var userName = ""
    @State private var email = ""
    var isDisabled: Bool {
        userName.count < 5 || email.count < 5
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    
                    Text(item.collectionName)
                }
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .frame(width: 200, height: 200)
            
            Spacer()
            
            Form {
                Section {
                    TextField("Username", text: $userName)
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Create account") {
                        print("Creating account..")
                    }
                    .disabled(isDisabled)
                }
            }
            
            Spacer()
        }
        .padding(.bottom)
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct CupcakeCornerPractice_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCornerPractice()
    }
}
