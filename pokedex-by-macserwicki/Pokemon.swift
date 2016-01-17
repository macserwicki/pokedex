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
    private var _pokemonURL: String!
    private var _nextEvolutionPokedexId: String!
    private var _nextEvolutionLevel: String!
    private var _nextEvolutionName: String!

    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
            
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionPokedexId: String {
        if _nextEvolutionPokedexId == nil {
            _nextEvolutionPokedexId = ""
        }
        return _nextEvolutionPokedexId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
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
                        self._type = "\(type.capitalizedString)"
                        print(type.capitalizedString)
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let type = types[x]["name"] {
                                self._type! += "/\(type.capitalizedString)"
                            }
                        }
                    }
                    print(self._type)
                    // Do stuff with parsed data
                    if let desc = pokeDictionary["descriptions"] as? [Dictionary<String, String>] where desc.count > 0 {
                        
                        if let descURL = desc[0]["resource_uri"] {
                            
                            let fullURL = NSURL(string: "\(URL_BASE)\(descURL)")!
                            
                            Alamofire.request(.GET, fullURL).responseJSON {
                                response in
                                 let descResult = response.result
                                
                                if let descriptionDictionary = descResult.value as? Dictionary<String, AnyObject> {
                                    if let descriptionString = descriptionDictionary["description"] as? String {
                                        
                                        if descriptionString.containsString("POKMON") {
                                            self._description = descriptionString.stringByReplacingOccurrencesOfString("POKMON", withString: "Pokemon")
                                        } else {
                                        self._description = descriptionString
                                        }
                                    }
                                }
                                
                                completed()
                            }

                        }
                        
                    } else {
                        print("Description parsing is nil")
                        self._description = ""
                    }
                    
                    if let evolutionDictionary = pokeDictionary["evolutions"] as? [Dictionary<String, AnyObject>] where evolutionDictionary.count > 0  {
                        if let name = evolutionDictionary[0]["to"] as? String where evolutionDictionary.count > 0 {
                            //mega data from API is not supported in the app
                            if name.rangeOfString("mega") == nil {
                                
                                if let evolutionURL = evolutionDictionary[0]["resource_uri"] as? String where evolutionDictionary.count > 0 {
                                    let newPokedexIdString = evolutionURL.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let pokedexNumberString = newPokedexIdString.stringByReplacingOccurrencesOfString("/", withString: "")
                                    self._nextEvolutionPokedexId = pokedexNumberString
                                    self._nextEvolutionName = name
                                    
                                    if let level = evolutionDictionary[0]["level"] as? Int {
                                        self._nextEvolutionLevel = String(level)
                                    }
                                    
                                   
                                }
                            }
                        }
                        
                       
                        
                    } else {
                        
                    }
                } else {
                    self._type = ""
                }
            }
        }
    }

    
}