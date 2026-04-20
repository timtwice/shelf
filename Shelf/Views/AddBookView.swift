//
//  AddBookView.swift
//  Shelf
//
//  Created by Timilehin Timothy on 16.04.26.
//

import SwiftUI
import PhotosUI

struct AddBookView : View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var bookName = "";
    @State private var author = "";
    @State private var status: BookStatus?
    @State private var additionalAuthors : [String] = [];
    
    @State private var bookCoverItem: PhotosPickerItem?
    @State private var bookCoverImage: Image?
    
    enum BookStatus : String, CaseIterable, Identifiable {
        case toRead = "To Read"
        case reading = "Reading"
        case done = "Done"
        
        var id: Self {self}
    }

    var body: some View {
        Form {
            // TODO: Add to Github ReadME to implement fetching book cover
            Section {
                PhotosPicker(selection: $bookCoverItem, matching: .any(of: [.images, .not(.screenshots)])) {
                    HStack {
                        Image(systemName: "camera")
                        Text("\(bookCoverImage == nil ? "Add" : "Replace") Cover Image")
                        
                        Spacer()
                        
                        if bookCoverImage != nil {
                            Button {
                                bookCoverItem = nil
                                bookCoverImage = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                }
                
                bookCoverImage?
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
              
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
                ForEach(additionalAuthors.indices.reversed(), id: \.self) { index in
                    TextField("Author \(index + 1)", text: $additionalAuthors[index])
                }
            } header: {
                HStack
                {
                    Text("Additional Authors")
                    Button {
                        let areAllAuthorsFilled = additionalAuthors.allSatisfy {
                            !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        }
                        
                        if areAllAuthorsFilled {
                            additionalAuthors.append("")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            } footer: {
                Text("Does the book have more than one author? Add more here.")
            }
        }
        .onChange(of: bookCoverItem) {
            Task {
                if let loaded = try? await bookCoverItem?.loadTransferable(type: Image.self) {
                    bookCoverImage = loaded
                }
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
