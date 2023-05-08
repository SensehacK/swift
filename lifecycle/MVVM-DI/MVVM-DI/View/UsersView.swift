//
//  InitialView.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject var viewModel: UsersViewModel = UsersViewModel()

    var body: some View {
        VStack {

            List(viewModel.users?.users ?? []) { user in
                Text(user.name)
            }
            .listStyle(.inset)
            
        }
        .padding()
        .onAppear {
            viewModel.fetchData()
//            viewModel.fetchUsers()
//            viewModel.fetchDummyUsers()
//            viewModel.fetchJSONPUsers()
//            viewModel.fetchUsersCallbacks()
//            viewModel.fetchUsersUsingSubjectPublisher()
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
