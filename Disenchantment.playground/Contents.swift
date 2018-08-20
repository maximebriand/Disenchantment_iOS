class Character {
    let name: String
    var life: Int
    var strong: Int
    
    init (name: String, life: Int, strong: Int){
        self.name = name
        self.life = life
        self.strong = strong
    }
    
    public func attack(opponent: Character) -> String{
        opponent.life += self.strong
        let message = "\(self.name) a attaqué \(opponent.name) et lui a ôté \(self.strong) points de vie. Il lui reste à présent \(opponent.life)"
        return message
    }
}

class Fighter : Character {
    init(name: String) {
        super.init(name: name, life: 100, strong: 30)
    }
    
}

class Magus : Character {
    init(name: String) {
        super.init(name: name, life: 70, strong: 25)
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
        super.init(name: name, life: 300, strong: 10)
    }
    
}

class Dward : Character {
    init(name: String) {
        super.init(name: name, life: 80, strong: 45)
    }
    
}


var jonathan = Colossus(name: "Jonathan")
var charles = Dward(name: "Charles")

jonathan.attack(opponent: charles)
charles.life


