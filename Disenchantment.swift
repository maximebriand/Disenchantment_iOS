class Team {
    var name: String?
    var teammate1: Character!
    var teammate2: Character!
    var teammate3: Character!
    var teammatesList = [Character]()
    
    init(teamNumber: Int) {
        print("Personnage \(teamNumber) quel est le nom de votre équipe ?")
        
        
        self.name = readLine()!
        print("\n  • Le Combattant est un attaquant classique, avec son épée il saura terrasser chacun de ses adversaire.")
        print("  • Le mage est pacificiste, il saura soigner presque toutes les blessures de ses compagnons d'armes.")
        print("  • Le Colosse, est certe lent et peu puissant, mais il est capable de resister à toutes les attaques sans broncher.")
        print("  • Le Nain, cet être est aussi petit qu'il est raleur, mais ne le sous-estimé pas, un coup de hache bien placé et votre vie pourrait être mise à mal.\n" )
        
        //TODO: create a function to loop if name is already used
        
        for _ in 0...2 { //depends of number of teammates, might be changed by a parameter set with the init.
            
            let characterType = self.selectCharacter()
            let teammate = self.createCharacter(characterType: characterType)
            self.teammatesList.append(teammate)
            newGame.characterList.append(teammate)
        }
        
        self.teammate1 = teammatesList[0]
        self.teammate2 = teammatesList[1]
        self.teammate3 = teammatesList[2]
        
    }
    
    func createCharacter(characterType: CharacterEnum) -> Character {
        print("Quel va être le nom de votre \(characterType) ?")
        
        
        var teammate: Character?
        if let teammateName = readLine() {
            let nameAvailable = self.isNameAvailable(characterName: teammateName)
            if nameAvailable {
                switch characterType {
                case .Fighter:
                    teammate = Fighter(name: teammateName)
                case .Magus:
                    teammate = Magus(name: teammateName)
                case .Colossus:
                    teammate = Colossus(name: teammateName)
                case .Dward:
                    teammate = Dward(name: teammateName)
                }
            } else {
                print("Désolé ce nom est déjà utilisé, merci d'en choisir un autre")
                teammate = self.createCharacter(characterType: characterType)
                return teammate!
            }
        }
        return teammate!
    }
    func selectCharacter() -> CharacterEnum {
        print("Parmi le Combattant, le Mage, le Colosse et le Nain qui souhaitez vous choisir ?")
        print("Quel personnage souhaitez vous choisir ?"
            + "\n\n1. le Combattant"
            + "\n2. le Mage"
            + "\n3. le Colosse"
            + "\n4. le Nain"
        )
        var characterType: CharacterEnum?
        
        if let characterChoise = readLine() {
            switch characterChoise {
            case "1":
                characterType = CharacterEnum.Fighter
            case "2":
                characterType = CharacterEnum.Magus
            case "3":
                characterType = CharacterEnum.Colossus
            case "4":
                characterType = CharacterEnum.Dward
            default:
                characterType = selectCharacter()
                return characterType!
            }
            return characterType!
        }
        
        return characterType!
    }

    
    
    func isNameAvailable(characterName: String) -> Bool {
        var nameAvailable = true
        print("teammates count \(newGame.characterList.count)")
        if newGame.characterList.count != 0 {
            for teammate in newGame.characterList {
                if teammate.name == characterName {
                    nameAvailable = false
                }
                return nameAvailable
            }
        }
        return nameAvailable
    }
    
}


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

enum CharacterEnum {
    case Fighter, Magus, Colossus, Dward
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



class Game {
    let numberOfPlayers: Int?
    var teamList = [Team]()
    var characterList = [Character]()
    
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
    }
    
    func startGame() {
        print("Les Règles sont les suivantes");
        print("Le joueur numéro 1 va tout d'abord choisir un nom d'équipe. Une fois cela fait il va choisir le type de personnage qu'il souhaite avoir dans son équipe. Chaque équipe doit se constituer de 3 personnages. Pas de restriction quant aux personnage.")
        for i in 1...self.numberOfPlayers! {
            let team = Team(teamNumber: i)
            teamList.append(team)
        }
        
        for team in teamList {
            while team.teammate1.life > 0 && team.teammate2.life > 0 && team.teammate3.life > 0 {
                team.teammate1.life -= 10
                print("un des perso n'a plus de vie !")
            }
        }
    }
    
    
}

var newGame = Game(numberOfPlayers: 2)
newGame.startGame()


