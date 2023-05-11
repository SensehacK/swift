//
//  PokemonDetailViewModel.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation

import Foundation

//MARK: - ViewModel

class PokemonDetailViewModel: ObservableObject {
    
    @Published var pokemon: PokemonDetailAPI?
    
    let serviceFetcher: PokemonService
    
    init(serviceFetcher: PokemonService = PokemonDataFetcher.shared) {
       self.serviceFetcher = serviceFetcher
    }
    

    func fetchPokemonDetails(id: Int) async {
        pokemon = await serviceFetcher.fetchPokemonDetails(id: id)
    }
    
    
    
}



