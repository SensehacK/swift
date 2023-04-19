//
//  UserCellView.swift
//  swiftUI-Users-Image-Cache
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI
import swift_sense

struct UserCellView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            if let url = URL(string: user.image) {
                HStack(alignment: .center) {
                    
                    VStack {
                        // without caching
//                        AsyncImage(url: url)
//                            .frame(height: 90)
//                            .clipShape(Circle())
                        
                        // with in-memory caching
                        AsyncImageCache(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .frame(height: 90)
                                    .clipShape(Circle())
                            case .empty:
                                Text("Image resource empty")
                            case .failure(let error):
                                Text("Error fetching Image: \(error.localizedDescription)")
                            default:
                                Text("No Image downloaded")
                            }
                        }
                        
                        HStack {
                            Text(user.firstName)
                            Text(user.lastName)
                        }
                    }
                    .frame(width: 160)
                    
                    HStack {
                        Text("H: \(user.height)")
                        Text("W: \(String(format:"%.2f", user.weight))")
                        Text(user.gender.rawValue.capitalized)
                    }

                }
                
            } else {
                Text("Hello, world!")
            }
        }
        .padding()
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        switch User.from(localJSON: "user") {
        case .success(let value):
            UserCellView(user: value)
        case .failure(_):
            Text("No Data loaded")

        }
    }
}
