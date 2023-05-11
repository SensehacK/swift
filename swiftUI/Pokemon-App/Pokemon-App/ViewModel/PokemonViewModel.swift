//
//  PokemonViewModel.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation

//MARK: - ViewModel
@MainActor
class PokemonViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonViewData]
    @Published var pokemonDetails: [PokemonDetailAPI]?
    
    let serviceFetcher: PokemonService
    
    init(pokemons: [PokemonViewData] = [],
         pokemonsDetails: [PokemonDetailAPI]?,
         serviceFetcher: PokemonService = PokemonDataFetcher.shared) {
        self.pokemons = pokemons
        self.pokemonDetails = pokemonsDetails
        self.serviceFetcher = serviceFetcher
    }
    
    func fetchData() async {
        pokemons = await serviceFetcher.fetchPokemons()
        fetchAllPokemons()
    }
    
    
    func fetchAllPokemons() {
        
        
        Task(priority: .userInitiated) {
            var pokemons: [PokemonDetailAPI] = []
            for pokemon in self.pokemons {
                print("Which ID: \(pokemon.id)")
                if let pokemonDetail = await serviceFetcher.fetchPokemonDetails(id: pokemon.id) {
                    pokemons.append(pokemonDetail)
                }
            }
            pokemonDetails = pokemons
        }
        
//        Task {
//            for pokemon in pokemons {
//                if let pokemonDetail = await serviceFetcher.fetchPokemonDetails(id: pokemon.id) {
//                    pokemons.append(pokemonDetail)
//                }
//            }
//        }
        
//        pokemonDetails = pokemons
        
    }
    
}






//MARK: - Consumable ViewData

struct PokemonViewData {
    let id: Int
    private let pokemon: PokeResult
    
    init(pokemon: PokeResult, id: Int) {
        self.pokemon = pokemon
        self.id = id
    }

    var name: String {
        pokemon.name
    }
    
    
    
}
