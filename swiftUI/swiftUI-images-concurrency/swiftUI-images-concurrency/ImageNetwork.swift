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
    
    // Async Task Group
    @Published var imagesAsyncGroup: [UIImage] = []
    
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
    
    // MARK: - Async Let Await
    
    func fetchImagesAsyncLet() async {
        
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
    
    
    
    
    // MARK: - Task Group Async Await
    
    func fetchImagesTaskGroup() async {
        if let images = try? await fetchImagesAsyncTaskGroup() {
            self.imagesAsyncGroup.append(contentsOf: images)
        }
        
    }
    
    private func fetchImagesAsyncTaskGroup() async throws -> [UIImage] {
        
        print("Fetching async task group Images ? ")
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { [weak self] group in
            guard let self = self else { throw URLError(.badURL) }
            var counter = 0
            var images: [UIImage] = []
            images.reserveCapacity(imagesArr.count)
            
            print("Initial Counter: \(counter)")
            
            for imageURL in imagesArr {
                counter += 1
                print("Current counter ++ \(counter)")
                group.addTask {
                    try await self.fetchSingleImage(url: imageURL)
                }
            }
            
            for try await image in group {
                if let image = image {
                    print("Getting Image")
                    images.append(image)
                    counter -= 1
                    print("Current counter -- \(counter)")
                }
            }
            
            print("Returning images")
            print("Final counter \(counter) ")
            return images
        }
    }
    
    private func fetchSingleImage(url: String) async throws -> UIImage {
        
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
        return image
    }
    
    
}
