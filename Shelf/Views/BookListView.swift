//
//  BookListView.swift
//  Shelf
//
//  Created by Timilehin Timothy on 16.04.26.
//

import SwiftUI

struct BookListView : View {
    @State private var showSheet = false
    
    var body : some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Holds the list of added books
                // TODO: Change to a grid view later on
                List(1..<25, id: \.self) { i in
                    Text("Book \(i)")
                }
                // Floating action button
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                }
                .padding()
                
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    AddBookView()
                }
            }
            .navigationTitle("My List")
        }
       
    }
}

#Preview {
    BookListView()
}
