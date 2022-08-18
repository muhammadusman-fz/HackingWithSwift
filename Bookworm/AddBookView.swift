//
//  AddBookView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 11/8/2022.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Horror"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Thriller"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("title", text: $title)
                TextField("author", text: $author)
                Picker("Select genere", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section {
                RatingView(rating: $rating)
                
                TextEditor(text: $review)
            } header: {
                Text("Write a review")
            }
            
            Section {
                Button("Save") {
                    if isValid() {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.reviews = review
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .disabled(!isValid())
        }
        .navigationTitle("Add book")
    }
    
    func isValid() -> Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
