class Character {
    let name: String
    var life: Int
    var strong: Int
    
    init (name: String, life: Int, strong: Int){
        self.name = name
        self.life = life
        self.strong = strong
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
