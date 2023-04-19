//
//  swiftUI_Users_Image_CacheApp.swift
//  swiftUI-Users-Image-Cache
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI
import swift_sense

@main
struct swiftUI_Users_Image_CacheApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            switch UsersAPI.from(localJSON: "users") {
            case .success(let value):
                UsersListView(users: value)
            case .failure(_):
                Text("No Data loaded")
            }
        }
    }
}
