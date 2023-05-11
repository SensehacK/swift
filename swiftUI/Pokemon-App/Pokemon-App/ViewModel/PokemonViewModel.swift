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
    
    let serviceFetcher: PokemonService
    
    init(pokemons: [PokemonViewData] = [], serviceFetcher: PokemonService = PokemonDataFetcher.shared) {
        self.pokemons = pokemons
        self.serviceFetcher = serviceFetcher
    }
    
    func fetchData() async {
        pokemons = await serviceFetcher.fetchPokemons()
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
