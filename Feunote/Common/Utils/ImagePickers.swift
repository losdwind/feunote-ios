//
//  ImagePickers.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import PhotosUI
import SwiftUI
struct ImagePickers: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Environment(\.presentationMode) var presentationMode
//    var selectionLimit: Int
    var mediaType: PHPickerFilter = .images

    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = mediaType
        config.selectionLimit = 9
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_: UIViewControllerType, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickers

        init(parent: ImagePickers) {
            self.parent = parent
        }

        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()

            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        guard let image1 = image else { return }

                        DispatchQueue.main.async {
//                                anyImage.image = (image1 as! UIImage).pngData()
                            self.parent.images.append(image1 as! UIImage)
                        }
                    }
                } else {
                    // Handle Error
                    parent.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
