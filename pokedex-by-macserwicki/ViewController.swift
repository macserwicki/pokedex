//
//  ViewController.swift
//  pokedex-by-macserwicki
//
//  Created by Maciej Serwicki on 1/11/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var musicBtn: UIButton!
   
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var musicPlayerPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        parsePokmeonCSVData()
        initAudio()
        
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!

        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            
            if !musicPlayerPlaying {
                musicPlayer.play()
                musicBtn.setImage(UIImage(named: "musicon"), forState: .Normal)
                
            } else {
                musicBtn.setImage(UIImage(named: "musicoff"), forState: .Normal)
                musicPlayer.stop()
            }
            
            musicPlayerPlaying = !musicPlayerPlaying
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
    }
    
    @IBAction func musicBtnPressed(sender: AnyObject) {
        initAudio()
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
            
            let pokemon = self.pokemon[indexPath.row]
            
            cell.configureCell(pokemon)
            
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemon.count
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
    
   

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

    

}

