//
//  FriendFaceView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 25/8/2022.
//

import SwiftUI

struct FriendFaceView: View {
    @State private var users = [User]()
    
    var body: some View {
        List(users) { user in
            NavigationLink {
                UserDetailView(user: user)
            } label: {
                HStack {
                    Circle()
                        .fill(user.isActive ? .green : .red)
                        .frame(width: 8)
                    
                    Text(user.name)
                }
            }
        }
        .navigationTitle("Friendface")
        .preferredColorScheme(.light)
        .task {
            await loadUsers()
        }
    }
    
    private func loadUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")  else {
            print("Inavalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Invalid data")
        }
        
    }
}

struct FriendFaceView_Previews: PreviewProvider {
    static var previews: some View {
        FriendFaceView()
    }
}
