//
//  PhotoPickerView.swift
//  ImagePickerDemo
//
//  Created by M W on 11/11/2022.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State private var photos: [PhotosPickerItem] = []
    @State private var selectedImages: [Image] = []
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $photos,
                matching: .images
            ) {
                Text("Photos")
            }
            
            if (photos.count > 0) {
                Text("Selected Photos")
                List {
                    ForEach(0..<selectedImages.count, id: \.self) { index in
                        selectedImages[index]
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            Spacer()
        }
        .font(.title)
        .onChange(of: photos) { newPhotos in
            Task {
                for newPhoto in newPhotos {
                    await selectedImages.append(newPhoto.convert())
                }
            }
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}


extension PhotosPickerItem {
    /// Load and return an image from a PhotosPickerItem
    func convert() async -> Image {
        do {
            if let image = try await self.loadTransferable(type: Image.self) {
                return image
            } else {
                return Image(systemName: "xmark.octagon")
            }
        } catch {
            print(error.localizedDescription)
            return Image(systemName: "xmark.octagon")
        }
    }
}
