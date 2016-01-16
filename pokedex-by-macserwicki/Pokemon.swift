//
//  Pokemon.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/11/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _pokemonURL: String!
    
    
    
    var name: String {
        return _name
    }
    
    var defense: String {
        return _defense
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)/\(_pokedexId)/"
    }
    
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let pokeDictionary = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = pokeDictionary["weight"] as? String {
                    print("weight is \(weight)")
                    self._weight = weight
                }
                
                if let height = pokeDictionary["height"] as? String {
                    print("height is \(height)")
                    self._height = height
                }
                
                if let defense = pokeDictionary["defense"] as? Int {
                    print ("defense is \(defense)")
                    self._defense = String(defense)
                }
                
                if let attack = pokeDictionary["attack"] as? Int {
                    print("attack is \(attack)")
                    self._attack = String(attack)
                }
                
            
                if let types = pokeDictionary["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let type = types[0]["name"]{
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let type = types[x]["name"] {
                                self._type! += "/\(type.capitalizedString)"
                            }
                        }
                    } else {
                        self._type = ""
                    }
                    print(self._type)
                }
            }
        }
    }

    
}