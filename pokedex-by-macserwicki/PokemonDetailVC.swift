//
//  PokemonDetailVC.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/14/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
}

    override func viewWillAppear(animated: Bool) {
        let labelString = pokemon.name.capitalizedString
        nameLbl.text = labelString

    }
  
   }
