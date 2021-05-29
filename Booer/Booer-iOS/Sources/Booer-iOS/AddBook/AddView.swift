//
//  AddView.swift
//  
//
//  Created by Veit Progl on 15.05.21.
//

import Foundation
import SwiftUI
import Booer_Shared

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

struct AddView: View {
    @Binding var isOpen: Bool
    @ObservedObject var book = AddBookData()
    
    @State private var isCorrect = true
    @State private var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    @State private var booktitle = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        self.book.image = inputImage
        image = Image(uiImage: inputImage)
    }
    
    fileprivate func LabeledTextedField(title: String, textField: Binding<String>) -> some View {
        return HStack() {
            Text(title + ":").bold()
            TextField(title, text: textField)
                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
        }.padding(1)
    }
    
    static var numerDottetFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.isLenient = false
        return nf
    }
    
    var body: some View {
        NavigationView() {
            List() {
                if !isCorrect {
                    Text("There is some required feld missing, plase check")
                        .foregroundColor(Color.red)
                }
                
                VStack() {
                    if image != nil {
                        image!
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                }
                
                Button(action: {
                    self.showingImagePicker = true
                }, label: {
                    Text("Add Cover")
                })
                
                Section(header: Text("Required")) {
                    VStack() {
                        HStack() {
                            LabeledTextedField(title: "Search", textField: self.$book.title)
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }, label: {
                                Image(systemName: "magnifyingglass")
                            })
                        }
                        LabeledTextedField(title: "Author", textField: self.$book.author)
                        
                        HStack() {
                            Text("Pages:").bold()
                            TextField("Pages", text: self.$book.pages)
                                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
                        }
                    }
                }
                
                Section(header: Text("Optional")) {
                    DatePicker(selection: self.$book.baugtAt, displayedComponents: .date, label: {
                        Text("Baugt at:").bold()
                    })
                        .datePickerStyle(CompactDatePickerStyle())
                }
            }
            .navigationTitle("Add Book")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction, content: {
                    Button(action: {
                        self.isCorrect = self.book.saveToDB(context: viewContext)
                    }, label: {
                        Text("Add")
                    })
                })
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction, content: {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Canncel")
                    })
                })
            })
        }
        .sheet(isPresented: self.$showSheet, content: {
            SearchBook(isOpen: self.$showSheet, book: book)
        })
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}
