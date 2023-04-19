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
                        AsyncImage(url: url)
                            .frame(height: 90)
                            .clipShape(Circle())
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
        
//        let userData = User
//        User
        switch User.from(localJSON: "user") {
        case .success(let value):
            UserCellView(user: value)
        case .failure(_):
            Text("No Data loaded")
//            print("Failure")
        }
        
//        UserCellView()
    }
}
