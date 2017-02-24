//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Macbook on 2/23/17.
//  Copyright © 2017 ahorro libre. All rights reserved.
//

import UIKit
import AVFoundation
class PokemonDetailVC: UIViewController {
	@IBOutlet weak var namelbl: UILabel!
	//@IBOutlet weak var speaker: UIButton!
	@IBOutlet weak var pokemonImage: UIImageView!
	@IBOutlet weak var pokemonDescription: UILabel!
	@IBOutlet weak var pokemonType: UILabel!
	@IBOutlet weak var pokemonDefense: UILabel!
	@IBOutlet weak var pokemonHeight: UILabel!
	@IBOutlet weak var pokemonPID: UILabel!
	@IBOutlet weak var pokemonWeight: UILabel!
	@IBOutlet weak var pokemonAttack: UILabel!
	@IBOutlet weak var evolutionlbl: UILabel!
	@IBOutlet weak var pokemoncurrentEvo: UIImageView!
	@IBOutlet weak var evolutionImg: UIImageView!

	
	let block = UIImage(named: "speakerblock")
	let noblock = UIImage(named: "speaker")
	var pokemon: Pokemon!
	//var musicPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
		namelbl.text = pokemon.name
		pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
		pokemoncurrentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
		
		pokemon.downloadPokemonDetails {
			//whatever we write will only be called after the network call is completed!
			self.updateUI()
		}
    }
	func updateUI(){
		
		pokemonDefense.text = pokemon.defense
		pokemonHeight.text = pokemon.Height
		pokemonPID.text = "\(pokemon.pokedexId)"
		pokemonWeight.text = pokemon.weight
		pokemonAttack.text = pokemon.attack
		pokemonType.text = pokemon.type
		pokemonDescription.text = pokemon.description
		if pokemon.nexEvolutionId == "" {
			evolutionlbl.text = "No Evolutions"
			evolutionImg.isHidden = true
		}else{
			evolutionImg.isHidden = false
			evolutionImg.image = UIImage(named: pokemon.nexEvolutionId)
			let str = "Next Evolution: \(pokemon.nexEvolutionName) - LVL \(pokemon.nexEvolutionLevel)"
			evolutionlbl.text = str
		}
		
	}

	@IBAction func backBtn(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}
