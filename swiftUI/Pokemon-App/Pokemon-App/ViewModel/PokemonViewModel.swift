//
//  PokemonViewModel.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation
import UIKit

//MARK: - ViewModel
@MainActor
class PokemonViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonViewData]
    @Published var pokemonDetails: [PokemonDetailAPI]?
    @Published var pokemonViewDetails: [PokemonDetailViewData]?
    
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
//        fetchAllPokemonsSequentially()
        fetchAllPokemonsAsync()
    }
    
    
    func fetchAllPokemonsSequentially() {

        Task(priority: .high) {
            var pokemons: [PokemonDetailAPI] = []
            for pokemon in self.pokemons {
                if let pokemonDetail = await serviceFetcher.fetchPokemonDetails(id: pokemon.id) {
                    pokemons.append(pokemonDetail)
                }
            }
            print("Completed all Pokemons 1st Gen")
            // If you don't keep this in Task { } then it will crash the preview. Or else assigning the value after the Task { } it would do it asynchronously and it just assigns empty array.
            pokemonDetails = pokemons
        }
    }
    
    
    func fetchAllPokemonsAsync() {

        Task(priority: .high) {
            var pokemons: [PokemonDetailViewData] = []
            for pokemon in self.pokemons {
                let pokeID = pokemon.id
                
                guard let pokemonDetail = await serviceFetcher.fetchPokemonDetails(id: pokeID)  else {
                    print("Error fetching poke detail")
                    return
                }
                
                guard let urlString = pokemonDetail.sprites.other?.officialArtwork.frontDefault,
                      let url = URL(string: urlString)
                else {
                    print("Couldn't find hero Image!")
                    return
                }
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    guard let imageData = UIImage(data: data) else {
                        print("Couldn't convert to image")
                        return
                    }
                    
                    
                    let pokemonDetailView = PokemonDetailViewData(pokemon: pokemonDetail, id: pokeID, image: imageData)
 
                    pokemons.append(pokemonDetailView)
                } catch {
                    print(error)
                }

            }
            print("Completed all Pokemons 1st Gen with Images")
            pokemonViewDetails = pokemons
        }
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

struct PokemonDetailViewData {
    let id: Int
    private let pokemon: PokemonDetailAPI
    let heroImage: UIImage
    
    init(pokemon: PokemonDetailAPI, id: Int, image: UIImage) {
        self.pokemon = pokemon
        self.id = id
        self.heroImage = image
    }

    var name: String {
        pokemon.name
    }
    
    var weight: String {
        "\(pokemon.weight)"
    }
    
    
}
