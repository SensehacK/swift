//
//  PokemonDetailView.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let pokemon: PokemonDetailAPI?
    let pokemonData: PokemonDetailViewData?
    let pokemonID: Int?
    
    @StateObject var viewModel: PokemonDetailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        
        VStack {
            
            if let pokemonData {
                PokemonOfflineView(pokemon: pokemonData)
            } else if let pokemon {
                PokemonViewID(pokemon: pokemon)
            } else if let pokemon = viewModel.pokemon {
                PokemonViewID(pokemon: pokemon)
            } else {
                ProgressView()
                Text("No Data to display")
            }
        }
        .task {
            if let pokemonID {
                await viewModel.fetchPokemonDetails(id: pokemonID)
            }
        }
        
        
        
        
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        PokemonDetailView(pokemonID: 25)
        PokemonDetailView(pokemon: nil, pokemonData: nil, pokemonID: nil)
    }
}


struct PokemonViewID: View {
    let pokemon: PokemonDetailAPI
    
    var body: some View {
        VStack {
            
            Text(pokemon.name)
            Text("Weight")
            Text("\(pokemon.weight)")
            if let urlString = pokemon.sprites.other?.officialArtwork.frontDefault {
                
                AsyncImage(url: URL(string:  urlString)!) { image in
                    image.resizable()
                        .frame(width: 400, height: 400)
                } placeholder: {
                    ProgressView()
                }
            }
            
        }
    }
}

struct PokemonOfflineView: View {
    let pokemon: PokemonDetailViewData
    
    var body: some View {
        VStack {
            Text("Offline Pokemon View")
            Text(pokemon.name)
            Text("Weight")
            Text(pokemon.weight)
            Image(uiImage: pokemon.heroImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
//                .frame(width: .infinity)
            
            
        }
        .padding(20)
    }
}
