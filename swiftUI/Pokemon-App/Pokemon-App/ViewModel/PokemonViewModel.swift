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
    @Published var pokemonViewAsync: [PokemonDetailViewData]?
    
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
//        fetchAllPokemonsDetailsWithoutImagesSync()
//        fetchAllPokemonsDetailsWithImagesSync()
        fetchAllPokemonsDetailsWithImagesAsync()
    }
    
    
    func fetchAllPokemonsDetailsWithoutImagesSync() {
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
    

    func fetchAllPokemonsDetailsWithImagesSync() {
        /*
         MEASURE_fetchAllPokemonsDetailsWithImagesSync
         Took 27.274075031280518 seconds
         21MB images
         */
        Task(priority: .high) {
            let start = CFAbsoluteTimeGetCurrent()
            // run your Async work
            await fetchAllPokemonsDetailsSync()
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("MEASURE_fetchAllPokemonsDetailsWithImagesInSequence")
            print("Took \(diff) seconds")
        }
    }
    
    func fetchAllPokemonsDetailsWithImagesAsync() {
        /*
         MEASURE_fetchAllPokemonsDetailsWithImagesAsync
         Took 0.6260659694671631 seconds
         21MB images
         */
        Task(priority: .high) {
            let start = CFAbsoluteTimeGetCurrent()
            // run your Async work
            pokemonViewAsync = try? await fetchPokemonsAsyncTaskGroup(pokemons: pokemons)
            
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("MEASURE_fetchAllPokemonsAsync")
            print("Took \(diff) seconds")
        }
    }

    
    
    
    
    // MARK: - Helper methods
    private func fetchAllPokemonsDetailsSync() async {
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
    
    
    // MARK: - Fetching Pokemon Details with Image Concurrently - Async
    private func fetchPokemonsAsyncTaskGroup(pokemons: [PokemonViewData]) async throws -> [PokemonDetailViewData] {
        return try await withThrowingTaskGroup(of: PokemonDetailViewData?.self) { [weak self] group in
            guard let self = self else { throw URLError(.backgroundSessionInUseByAnotherProcess) }
            var images: [PokemonDetailViewData] = []
            images.reserveCapacity(151)
            
            for pokemon in pokemons {
                group.addTask {
                    try await self.fetchSinglePokemonDetailView(pokeID: pokemon.id)
                }
            }

            for try await image in group {
                if let image = image { images.append(image) }
            }
            print("Done fetching All pokemons Async Concurrently")
            return images
        }
    }

    private func fetchSinglePokemonDetailView(pokeID: Int) async throws -> PokemonDetailViewData {
        
        guard let pokemonDetail = await serviceFetcher.fetchPokemonDetails(id: pokeID) else {
            print("Error fetching poke detail")
            throw URLError(.badURL)
        }
        
        guard let urlString = pokemonDetail.sprites.other?.officialArtwork.frontDefault else {
            print("Couldn't find hero Image!")
            throw URLError(.badURL)
        }
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let imageData = UIImage(data: data) else { throw URLError(.badURL) }
        
        let pokemonDetailView = PokemonDetailViewData(pokemon: pokemonDetail, id: pokeID, image: imageData)
        return pokemonDetailView
    }
}
