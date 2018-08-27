//
//  Team.swift
//  Desenchantment
//
//  Created by Maxime BRIAND on 27/08/2018.
//

import Foundation

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
        if Game.characterList.count != 0 {
            for teammate in Game.characterList {
                if teammate.name == characterName {
                    nameAvailable = false
                }
                return nameAvailable
            }
        }
        return nameAvailable
    }
    
}
