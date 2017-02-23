//
//  PokeCell.swift
//  Pokedex
//
//  Created by Macbook on 2/22/17.
//  Copyright © 2017 ahorro libre. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonlbl: UILabel!
    
    var pokemon: Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokemonlbl.text = self.pokemon.name.capitalized
        pokemonImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
