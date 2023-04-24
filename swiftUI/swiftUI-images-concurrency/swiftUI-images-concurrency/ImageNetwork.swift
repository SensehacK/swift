//
//  ImageNetwork.swift
//  swiftUI-images-concurrency
//
//  Created by Kautilya Save on 4/23/23.
//

import UIKit

@MainActor
class ImageNetwork: ObservableObject {
    
    // Sync
    var imagesData: [Data] = []
    @Published var images: [UIImage] = []
    
    // Async
    var imagesAsyncData: [Data] = []
    @Published var imagesAsync: [UIImage] = []
    
    let imagesArr: [String] = [
        "https://picsum.photos/2020",
        "https://picsum.photos/500",
        "https://picsum.photos/530",
        "https://picsum.photos/4020",
        "https://picsum.photos/690",
        "https://picsum.photos/700",
        "https://picsum.photos/840",
        "https://picsum.photos/2050",
        "https://picsum.photos/2400"
    ]

    
    func fetchImages() async {
        print("Fetching images")
        
        do {
            for imageURL in imagesArr {
                print(imageURL)
                let (imageData, _) =  try await URLSession.shared.data(from: URL(string: imageURL)!)
                guard let image = UIImage(data: imageData) else { continue }
                images.append(image)
                
            }
        } catch {
            print("Error getting data")
        }

    }
    
    
    func fetchImagesAsync() async {
        
        print("Fetching async Images ? ")
        do {
            async let (imageData0, _) = try URLSession.shared.data(from: URL(string: imagesArr[0])!)
            async let (imageData1, _) = try URLSession.shared.data(from: URL(string: imagesArr[1])!)
            async let (imageData2, _) = try URLSession.shared.data(from: URL(string: imagesArr[2])!)
            async let (imageData3, _) = try URLSession.shared.data(from: URL(string: imagesArr[3])!)
            async let (imageData4, _) = try URLSession.shared.data(from: URL(string: imagesArr[4])!)
            async let (imageData5, _) = try URLSession.shared.data(from: URL(string: imagesArr[5])!)
            async let (imageData6, _) = try URLSession.shared.data(from: URL(string: imagesArr[6])!)
            async let (imageData7, _) = try URLSession.shared.data(from: URL(string: imagesArr[7])!)
            async let (imageData8, _) = try URLSession.shared.data(from: URL(string: imagesArr[8])!)
            
            imagesAsyncData.append(contentsOf: try await [imageData0, imageData1,imageData2,
                                           imageData3,imageData4, imageData5,
                                           imageData6, imageData7, imageData8])
            
            for imageData in imagesAsyncData {
                guard let image = UIImage(data: imageData) else { continue }
                imagesAsync.append(image)
            }
        } catch {
            print("Error getting data")
        }
    }
    
    
    
}
