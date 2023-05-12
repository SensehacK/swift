//
//  PokemonView.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import SwiftUI

struct PokemonView: View {
    
    @StateObject var viewModel: PokemonViewModel = PokemonViewModel(pokemonsDetails: nil)
    @State var viewDidLoad: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                List(viewModel.pokemons, id: \.id) { pokemon in
                    NavigationLink {
                    
                        if let data = viewModel.pokemonViewAsync {
                            let pokemon = data[pokemon.id-1]
                            PokemonDetailView(pokemon: nil, pokemonData: pokemon, pokemonID: nil)
                        } else if let data = viewModel.pokemonViewDetails {
                            let pokemon = data[pokemon.id-1]
                            PokemonDetailView(pokemon: nil, pokemonData: pokemon, pokemonID: nil)
                        } else if let data = viewModel.pokemonDetails {
                            let pokemon = data[pokemon.id-1]
                            Text("Details \(pokemon.name) \(pokemon.height)")
                            PokemonDetailView(pokemon: pokemon, pokemonData: nil, pokemonID: nil)
                        } else {
                            Text("Wrong if else")
                            PokemonDetailView(pokemon: nil, pokemonData: nil, pokemonID: 25)
                        }

                    } label: {
                        Text(pokemon.name)
                    }
                }
                .listStyle(.plain)
            }
            .task {
                if !viewDidLoad {
                    await viewModel.fetchData()
                    viewDidLoad = true
                }
                
            }
            .padding()
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
