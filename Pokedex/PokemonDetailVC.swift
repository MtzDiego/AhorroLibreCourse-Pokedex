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
	@IBOutlet weak var speaker: UIButton!
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
	var musicPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
		namelbl.text = pokemon.name
		initAudio()
    }
	func initAudio(){
		let path = Bundle.main.path(forResource: "music", ofType: "mp3")
		do{
			musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
			musicPlayer.prepareToPlay()
			musicPlayer.numberOfLoops = -1
			musicPlayer.play()
		}catch let err as NSError{
			print(err.debugDescription)
		}
	}
	@IBAction func music(_ sender: Any) {
		if musicPlayer.isPlaying == true{
			speaker.setImage(block, for: .normal)
			musicPlayer.pause()
		}else if musicPlayer.isPlaying == false{
			speaker.setImage(noblock, for: .normal)
			musicPlayer.play()
		}
	}
	@IBAction func backBtn(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}
