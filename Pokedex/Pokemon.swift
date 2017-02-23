//
//  Pokemon.swift
//  Pokedex
//
//  Created by Macbook on 2/22/17.
//  Copyright © 2017 ahorro libre. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
	private var _description: String!
	private var _type: String!
	private var _defense: Double!
	private var _Height: Double!
	private var _attack: Double!
	private var _weight: Double!
	private var _nextEvolution: String!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
