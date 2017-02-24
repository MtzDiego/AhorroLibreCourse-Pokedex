//
//  Pokemon.swift
//  Pokedex
//
//  Created by Macbook on 2/22/17.
//  Copyright © 2017 ahorro libre. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
	private var _description: String!
	private var _type: String!
	private var _defense: String!
	private var _Height: String!
	private var _attack: String!
	private var _weight: String!
	private var _nextEvolution: String!
	private var _nextEvolutionName: String!
	private var _nextEvolutionId: String!
	private var _nextEvolutionLevel: String!
	private var _pokemonURL: String!
	var nexEvolutionName: String{
		if _nextEvolutionName == nil{
			_nextEvolutionName = ""
		}
		return _nextEvolutionName
	}
	var nexEvolutionId: String{
		if _nextEvolutionId == nil{
			_nextEvolutionId = ""
		}
		return _nextEvolutionId
	}
	var nexEvolutionLevel: String{
		if _nextEvolutionLevel == nil{
			_nextEvolutionLevel = ""
		}
		return _nextEvolutionLevel
	}
	var description: String{
		if _description == nil{
			_description = "Unknown"
		}
		return _description
	}

	var type: String{
		if _type == nil{
			_type = "Unknown"
		}
		return _type
	}

	var defense: String{
		if _defense == nil{
			_defense = "Unknown"
		}
		return _defense
	}

	var Height: String{
		if _Height == "0"{
			_Height = "Unknown"
		}
		return _Height
	}

	var attack: String{
		if _attack == nil{
			_attack = "Unknown"
		}
		return _attack
	}
	var weight: String{
		if _weight == "0"{
			_weight = "Unknown"
		}
		return _weight
	}

	var nextEvolutionText: String{
		if _nextEvolution == nil{
			_nextEvolution = ""
		}
		return _nextEvolution
	}
	
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
		
		self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
	func downloadPokemonDetails(completed: @escaping DownloadComplete) {
		Alamofire.request(_pokemonURL).responseJSON{(response) in
			if let dict = response.result.value as? Dictionary<String, AnyObject>{
				if let weight = dict["weight"] as? String{
					self._weight = weight
				}
				if let height = dict["height"] as? String{
					self._Height = height
				}
				if let attack = dict["attack"] as? Double{
					self._attack = "\(attack)"
				}
				if let defense = dict["defense"] as? Double{
					self._defense = "\(defense)"
				}
				print(self._weight)
				print(self._Height)
				print(self._attack)
				print(self._defense)
				print(self._name)
				if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count>0{
					if let name = types[0]["name"]{
						self._type = name.capitalized
					}
					if types.count > 1{
						for x in 1..<types.count{
							if let name = types[x]["name"]{
								self._type! += "/" + name.capitalized
							}
						}
					}
				}else {
					self._type = ""
				}
				if let descriptionArr = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptionArr.count>0{
					if let url = descriptionArr[0]["resource_uri"]{
						let urlcomp = "\(URL_BASE)\(url)"
						Alamofire.request(urlcomp).responseJSON(completionHandler: {(response) in
							if let descDict = response.result.value as? Dictionary<String, AnyObject>{
								if let description = descDict["description"] as? String{
									let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
									self._description = newDescription
									print(newDescription)
								}
							}
							completed()
						})
					}
				}else{
					self._description = ""
				}
				if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count>0{
					if let nextEvo = evolutions[0]["to"] as? String{
						if nextEvo.range(of: "mega") == nil{
							self._nextEvolutionName = nextEvo
							if let uri = evolutions[0]["resource_uri"] as? String{
								let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
								let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
								self._nextEvolutionId = nextEvoId
								if let lvlExist = evolutions[0]["level"]{
									if let lvl = lvlExist as? Int{
										self._nextEvolutionLevel = "\(lvl)"
									}
								}else{
									self._nextEvolutionLevel = ""
								}
							}
						}
					}
					print(self.nexEvolutionLevel)
					print(self.nexEvolutionId)
					print(self.nexEvolutionName)
				}
			}
			completed()
		}
	}
}
