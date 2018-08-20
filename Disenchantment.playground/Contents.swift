class Character {
    let name: String
    var life: Int
    var strong: Int
    var weapon: Weapon
    
    init (name: String, life: Int, strong: Int, weapon: WeaponEnum){
        self.name = name
        self.life = life
        self.strong = strong
        
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
        opponent.life += self.strong
        let message = "\(self.name) a attaqué \(opponent.name) et lui a ôté \(self.strong) points de vie. Il lui reste à présent \(opponent.life)"
        return message
    }
}

enum ArenaType {
    case fire, water, plant, basic
}

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

class Fighter : Character {
    init(name: String) {
        super.init(name: name, life: 100, strong: 30, weapon: WeaponEnum.sword)
    }
    
}

class Magus : Character {
    init(name: String) {
        super.init(name: name, life: 70, strong: 25, weapon: WeaponEnum.wand)
    }
    
    public override func attack(opponent: Character) -> String {
        let message = "Désolé mais est un mage, il ne peut pas attaquer. Mais il peut soigner l'un de ses amis."
        return message
    }
    
    public func treat(teammate: Character) -> String{
        teammate.life += self.strong
        let message = "\(self.name) a soigné \(teammate.name) et lui a restauré \(self.strong) points de vie. Il lui reste à présent \(teammate.life)"
        return message
    }
    
}

class Colossus : Character {
    init(name: String) {
        super.init(name: name, life: 300, strong: 10, weapon: WeaponEnum.none)
    }
    
}

class Dward : Character {
    init(name: String) {
        super.init(name: name, life: 80, strong: 45, weapon: WeaponEnum.ax)
    }
    
}


var jonathan = Colossus(name: "Jonathan")
var charles = Dward(name: "Charles")
var yohann = Magus(name: "Yohann")
jonathan.attack(opponent: charles)
charles.life
yohann.treat(teammate: charles)
charles.life
charles.weapon.name
