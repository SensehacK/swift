//
//  ImageNetwork.swift
//  swiftUI-images-concurrency
//
//  Created by Kautilya Save on 4/23/23.
//

import UIKit

//@MainActor
class ImageNetwork: ObservableObject {
    
    var imagesData: [Data] = []
    @Published var images: [UIImage] = []
    
    let imagesArr: [String] = [
        "https://picsum.photos/600",
        "https://picsum.photos/500",
        "https://picsum.photos/530",
        "https://picsum.photos/400",
        "https://picsum.photos/690",
        "https://picsum.photos/800",
        "https://picsum.photos/840",
        "https://picsum.photos/1040",
        "https://picsum.photos/240"
    ]
    
    func fetchImages() async throws {
        print("Fetching images")
        
        do {
            //        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://picsum.photos/600")!)
            let (imageData0, _) = try await URLSession.shared.data(from: URL(string: imagesArr[0])!)
            let (imageData1, _) = try await URLSession.shared.data(from: URL(string: imagesArr[1])!)
            let (imageData2, _) = try await URLSession.shared.data(from: URL(string: imagesArr[2])!)
            let (imageData3, _) = try await URLSession.shared.data(from: URL(string: imagesArr[3])!)
            let (imageData4, _) = try await URLSession.shared.data(from: URL(string: imagesArr[4])!)
            let (imageData5, _) = try await URLSession.shared.data(from: URL(string: imagesArr[5])!)
            let (imageData6, _) = try await URLSession.shared.data(from: URL(string: imagesArr[6])!)
            let (imageData7, _) = try await URLSession.shared.data(from: URL(string: imagesArr[7])!)
            let (imageData8, _) = try await URLSession.shared.data(from: URL(string: imagesArr[8])!)
            
            imagesData.append(contentsOf: [imageData0, imageData1,imageData2,
                                           imageData3,imageData4, imageData5,
                                           imageData6, imageData7, imageData8])
            
            for imageData in imagesData {
                guard let image = UIImage(data: imageData) else { continue }
                images.append(image)
            }
        } catch {
            print("Error getting data")
        }
        
        
        
        
        
        
    }
    
    
    
}
