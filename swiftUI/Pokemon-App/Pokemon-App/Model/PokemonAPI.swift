//
//  PokemonAPI.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation


struct PokemonAPI: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokeResult]
}


struct PokeResult: Codable {
    let name: String
    let url: String
}


/*
 
 {
     "count": 1281,
     "next": "https://pokeapi.co/api/v2/pokemon/?offset=151&limit=151",
     "previous": null,
     "results": [
         {
             "name": "bulbasaur",
             "url": "https://pokeapi.co/api/v2/pokemon/1/"
         },
 */
