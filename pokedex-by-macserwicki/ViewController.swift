//
//  ViewController.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/11/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
   
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    
    var inSearchMode: Bool = false
    
    var musicPlayer: AVAudioPlayer!
    var musicPlayerPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        parsePokmeonCSVData()
        initAudio()
        
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!

        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.25
            musicPlayer.play()
            
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
    }
    
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            musicBtn.setImage(UIImage(named: "musicoff"), forState: .Normal)
            sender.alpha = 0.66
            } else {
            musicPlayer.play()
            musicBtn.setImage(UIImage(named: "musicon"), forState: .Normal)
            sender.alpha = 1.0
        }
        
    }
    
    func parsePokmeonCSVData() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
      
                let pokemonID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokemonID)
                pokemon.append(poke)
              
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell {
            
            var pokemon: Pokemon!
            
            if inSearchMode {
                 pokemon = self.filteredPokemon[indexPath.row]
            } else {
                 pokemon = self.pokemon[indexPath.row]
            }
            
            
            cell.configureCell(pokemon)
            
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // segue
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let size = ((screenSize.width - 70) / 3)
        // let size = ((screenSize.width - screenSize.width * 0.33) / 3)
        //105 size is a good constant size
        return CGSizeMake(size, size)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lowercase = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lowercase) != nil})
            self.collection.reloadData()
        }
        
    }
   
 

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

    

}

