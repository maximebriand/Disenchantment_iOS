//
//  Weapon.swift
//  Desenchantment
//
//  Created by Maxime BRIAND on 27/08/2018.
//

import Foundation

class Weapon {
    let name: String
    let type: ArenaType
    let power: Int
    
    init(weaponName: String, weaponType: ArenaType, weaponPower: Int) {
        self.name = weaponName
        self.type = weaponType
        self.power = weaponPower
    }
    
    
}

enum WeaponEnum {
    case sword, ax, wand, none
}
