//
//  AddBookView.swift
//  Shelf
//
//  Created by Timilehin Timothy on 16.04.26.
//

import SwiftUI

struct AddBookView : View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var bookName = "";
    @State private var author = "";
    @State private var status: BookStatus?
    @State private var additionalAuthors : [String] = [];
    
    enum BookStatus : String, CaseIterable, Identifiable {
        case toRead = "To Read"
        case reading = "Reading"
        case done = "Done"
        
        var id: Self {self}
    }

    var body: some View {
        Form {
            // TODO: User takes picture for now (mandatory)
            // TODO: Add to Github ReadME to implement fetching book cover
            Text("Add Cover Image")
            
            Section {
                TextField("Book Title", text: $bookName)
                TextField("Author\'s Name", text: $author)
                
                Picker("Status", selection: $status) {
                    Text("Select a status")
                        .tag(nil as BookStatus?)
                    ForEach(BookStatus.allCases) { status in
                        Text(status.rawValue.capitalized)
                            .tag(status, includeOptional: true)
                    }
                }
                     
            } header: {
                HStack {
                    Image(systemName: "book")
                    Text("Details")
                }
            } footer: {
                Text("Please provide accurate information to use on your Shelf.")
            }
            
            Section {
                ForEach(additionalAuthors.indices, id: \.self) { index in
                    TextField("Author \(index + 1)", text: $additionalAuthors[index])
                }
            } header: {
                HStack
                {
                    Text("Additional Authors")
                    Button {
                        // TODO: Do not add more fields if the previous one hasn't been filled
                        additionalAuthors.append("")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            } footer: {
                Text("Does the book have more than one author? Add more here.")
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
        .presentationBackground(Color(.systemBackground))
        .navigationTitle("Add Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    
                }
            }
            
        }
    }
}


#Preview {
    NavigationStack {
        AddBookView()
    }
}
