//
//  PokemonView.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import SwiftUI

struct PokemonView: View {
    
    @StateObject var viewModel: PokemonViewModel = PokemonViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.pokemons, id: \.id) { pokemon in
                Text(pokemon.name)
            }
        }
        .task {
            await viewModel.fetchData()
        }
        .padding()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
