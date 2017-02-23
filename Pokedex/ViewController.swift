//
//  ViewController.swift
//  Pokedex
//
//  Created by Macbook on 2/22/17.
//  Copyright © 2017 ahorro libre. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var speaker: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
	
    var pokemon = [Pokemon]()
	var filterPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
	var inSearchMode = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collection.delegate = self
		collection.dataSource = self
		searchBar.delegate = self
		parsePokemonCSV()
		initAudio()
		searchBar.returnKeyType = UIReturnKeyType.done

	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
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
	func parsePokemonCSV(){
		let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
		do{
			let csv = try CSV(contentsOfURL: path)
			let rows = csv.rows
			print(rows)
			
			for row in rows{
				let pokeId = Int(row["id"]!)!
				let name = row["identifier"]!
				let poke = Pokemon(name: name, pokedexId: pokeId)
				pokemon.append(poke)
			}
		}catch let err as NSError{
			print(err.debugDescription)
		}
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
			let poke: Pokemon!
			if inSearchMode{
				poke = filterPokemon[indexPath.row]
				cell.configureCell(poke)
			}else {
				poke = pokemon[indexPath.row]
				cell.configureCell(poke)
			}
			return cell
		}else {
			return UICollectionViewCell()
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var poke: Pokemon!
		
		if inSearchMode{
			poke = filterPokemon[indexPath.row]
		}else{
			poke = pokemon[indexPath.row]
		}
		performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
		
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if inSearchMode{
			return filterPokemon.count
		}
		return pokemon.count
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 105, height: 105)
	}
	@IBAction func speakerBtn(_ sender: Any) {
		let block = UIImage(named: "speakerblock")
		let noblock = UIImage(named: "speaker")
		if speaker.currentImage == UIImage(named: "speaker"){
			speaker.setImage(block, for: .normal)
			musicPlayer.pause()
		}else if speaker.currentImage == UIImage(named: "speakerblock"){
			speaker.setImage(noblock, for: .normal)
			musicPlayer.play()
		}
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text == nil || searchBar.text == ""{
			inSearchMode = false
			collection.reloadData()
			view.endEditing(true)
		}else {
			inSearchMode = true
			let lower = searchBar.text!.lowercased()
			filterPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
			collection.reloadData()
		}
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PokemonDetailVC"{
			if let detailsVC = segue.destination as? PokemonDetailVC{
				if let poke = sender as? Pokemon{
					detailsVC.pokemon = poke
				}
			}
			
		}
	}
}

