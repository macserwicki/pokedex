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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evolutionImgCurrent: UIImageView!
    @IBOutlet weak var evolutionImgNext: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelString = pokemon.name.capitalizedString
        let currentImg = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = labelString
        mainImg.image = currentImg
        evolutionImgCurrent.image = currentImg
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails { () -> () in
            //called after download is finished
            self.updateUI()
        }
        
}

    
    func updateUI() {
      
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        baseAttackLbl.text = pokemon.attack
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        
        if pokemon.nextEvolutionName == "" {
            evolutionImgNext.hidden = true
            evolutionLbl.text = "No Further Evolutions"
            
        } else {
            evolutionImgNext.hidden = false
            evolutionImgNext.image = UIImage(named: pokemon.nextEvolutionPokedexId)
           
            var evoString: String = "Next Evolution: \(pokemon.nextEvolutionName)"
           
            if pokemon.nextEvolutionLevel != "" {
                evoString.appendContentsOf(" LVL \(pokemon.nextEvolutionLevel)")
            }
            
            evolutionLbl.text = evoString
            
            }
        
    }
    
    
  
    @IBAction func backButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
    }
    
   }
