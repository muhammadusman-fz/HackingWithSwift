//
//  BookwormView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 8/8/2022.
//

import SwiftUI

struct BookwormView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        VStack {
            List {
                ForEach(books) { book in
                    HStack {
                        NavigationLink {
                            BookwormDetailView(book: book)
                        } label: {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                Text(book.genre ?? "Unknown author")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
        }
        .navigationTitle("Bookworm")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Label("Add Book", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddBookView()
        }
    }
    
    func deleteBook(at offSets: IndexSet) {
        for offset in offSets {
            let book = books[offset]
            
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct BookwormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookwormView()
        }
    }
}
