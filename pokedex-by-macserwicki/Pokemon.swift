//
//  Pokemon.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/11/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
    }
    
}