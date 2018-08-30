//
//  Character.swift
//  Desenchantment
//
//  Created by Maxime BRIAND on 27/08/2018.
//

import Foundation

class Character {
    let name: String
    var life: Int
    var strength: Int
    var weapon: Weapon
    var type: CharacterEnum
    var isDead = false
    
    init (name: String, life: Int, strength: Int, weapon: WeaponEnum, type: CharacterEnum){
        self.name = name
        self.life = life
        self.strength = strength
        self.type = type
        
        switch weapon {
        case WeaponEnum.sword:
            self.weapon = Weapon(weaponName: "Epée", weaponType: ArenaType.basic, weaponPower: 0)
        case WeaponEnum.ax:
            self.weapon = Weapon(weaponName: "Hache", weaponType: ArenaType.basic, weaponPower: 0)
        case WeaponEnum.wand:
            self.weapon = Weapon(weaponName: "Baguette Magique", weaponType: ArenaType.basic, weaponPower: 0)
        case WeaponEnum.none:
            self.weapon = Weapon(weaponName: "Mains nues", weaponType: ArenaType.basic, weaponPower: 0)
        }
        
    }
    
    public func attack(opponent: Character) -> String{

        var message = ""
        opponent.life -= self.strength
        if (opponent.life < 0) {
            opponent.life = 0
            opponent.isDead = true
            message = "\(self.name) a attaqué \(opponent.name) et l'a envoyé outre tombe. \n\n"
        }
        message = "\(self.name) a attaqué \(opponent.name) et lui a ôté \(self.strength) points de vie. Il lui reste à présent \(opponent.life) \n\n"
        
        return message
    }
    
    public func beTreated(teammate: Character) -> String{
        self.life += teammate.strength
        let message = "\(teammate.name) a soigné \(self.name) et lui a restauré \(teammate.strength) points de vie. Il lui reste à présent \(self.life)\n\n"
        return message
    }
}

class Fighter : Character {
    init(name: String) {
        super.init(name: name, life: 100, strength: 30, weapon: WeaponEnum.sword, type: .Fighter)
    }
    
}

class Magus : Character {
    init(name: String) {
        super.init(name: name, life: 70, strength: 25, weapon: WeaponEnum.wand, type: .Magus)
    }
    
    public override func attack(opponent: Character) -> String {
        let message = "Désolé mais est un mage, il ne peut pas attaquer. Mais il peut soigner l'un de ses amis."
        return message
    }
    
}

class Colossus : Character {
    init(name: String) {
        super.init(name: name, life: 300, strength: 10, weapon: WeaponEnum.none, type: .Colossus)
    }
    
}

class Dward : Character {
    init(name: String) {
        super.init(name: name, life: 80, strength: 45, weapon: WeaponEnum.ax, type: .Dward)
    }
    
}

enum CharacterEnum {
    case Fighter, Magus, Colossus, Dward
}
