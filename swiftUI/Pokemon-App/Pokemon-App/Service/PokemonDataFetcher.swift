//
//  PokemonDataFetcher.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation

protocol PokemonService {
    
    func fetchPokemons() async -> [PokemonViewData]
    func fetchPokemonDetails(id: Int) async -> PokemonDetailAPI?
}


class PokemonDataFetcher: PokemonService {
    
    static var shared: PokemonDataFetcher = PokemonDataFetcher()
    private init() { }
    
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
    
    
    func fetchPokemonDetails(id: Int) async -> PokemonDetailAPI? {
        
        do {
            let url = URLConstants.pokemonBaseURL + String(id)
            let data = try await NetworkManager.shared.fetchData(url: url)
            let decodedData = try JSONDecoder().decode(PokemonDetailAPI.self, from: data)
            return decodedData
        } catch {
            print(error)
            print(error.localizedDescription)
        }

        return nil
    }
    
    
}
