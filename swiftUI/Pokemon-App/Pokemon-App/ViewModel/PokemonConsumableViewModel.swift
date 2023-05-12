//
//  PokemonConsumableViewModel.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation
import UIKit

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
