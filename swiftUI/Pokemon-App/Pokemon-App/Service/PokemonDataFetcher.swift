//
//  PokemonDataFetcher.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation

protocol PokemonService {
    
    func fetchPokemons() async -> [PokemonViewData]
    
}


class PokemonDataFetcher: PokemonService {
    
    
    func fetchPokemons() async -> [PokemonViewData] {
        
        do {
            let data = try await NetworkManager.shared.fetchData(url: URLConstants.pokemonFirstGen)
            
            let decodedData = try JSONDecoder().decode(PokemonAPI.self, from: data)
            
            
            var pokemonViewData: [PokemonViewData] = []
            for (index, pokemon) in decodedData.results.enumerated() {
                pokemonViewData.append(PokemonViewData(pokemon: pokemon, id: index+1))
            }

            return pokemonViewData
            
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        return []
        
    }
    
    
}
