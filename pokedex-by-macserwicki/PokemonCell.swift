//
//  PokemonCell.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/13/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 10
        
    }
    
    
    
    //sets up cell
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: String(self.pokemon.pokedexId))
        
        
    }
    
}
