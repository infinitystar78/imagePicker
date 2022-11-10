//
//  ContentView.swift
//  ImagePickerDemo
//
//  Created by M W on 10/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button {
                showingImagePicker.toggle()
            } label: {
                Text("Click for Images")
            }
            .padding()
        }
        .sheet(isPresented:$showingImagePicker){
            ImagePicker(image: $selectedImage)
        }
        
        .onChange(of: selectedImage) { _ in
            loadImage()
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
