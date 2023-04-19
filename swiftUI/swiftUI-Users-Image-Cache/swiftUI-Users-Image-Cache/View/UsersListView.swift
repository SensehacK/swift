//
//  UsersListView.swift
//  swiftUI-Users-Image-Cache
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI
import swift_sense

struct UsersListView: View {
    
    let users: UsersAPI
    
    var body: some View {
        List(users.users, id: \.id) { user in
            UserCellView(user: user)
        }
        
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        switch UsersAPI.from(localJSON: "users") {
        case .success(let value):
            UsersListView(users: value)
        case .failure(_):
            Text("No Data loaded")

        }
    }
}
