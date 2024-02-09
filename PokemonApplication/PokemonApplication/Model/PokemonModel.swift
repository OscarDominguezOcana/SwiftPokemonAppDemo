//
//  PokemonModel.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 1/2/24.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    var id: Int
    let name: String
    let url: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        
        let components = url.components(separatedBy: "/")
        if let lastComponent = components.dropLast().last, let parsedId = Int(lastComponent) {
            id = parsedId
        } else {
            id = -1
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
    
    init(name: String, url: String){
        self.id = 0
        self.name = name
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.url == rhs.url
    }
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemonCodable: Codable {
    let id: Int
    let height: Int
    let weight: Int
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    var favorite: Bool
    var name: String
    var url: String
    
    init(id: Int, height: Int, weight: Int, favorite: Bool = false, name: String = "", url: String = "") {
        self.id = id
        self.height = height
        self.weight = weight
        self.favorite = favorite
        self.name = name
        self.url = url
    }
}
