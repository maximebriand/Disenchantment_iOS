
//
//  Game.swift
//  Desenchantment
//
//  Created by Maxime BRIAND on 27/08/2018.
//

import Foundation

class Game {
    let numberOfPlayers: Int?
    var teamList = [Team]()
    var characterList = [Character]()
    
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
    }
    
    func createTeam(teamNumber: Int) -> Team {
        //var teamName: String

        print("Personnage \(teamNumber) quel est le nom de votre équipe ?")
        
        
        if let teamName = readLine() {
            print("\n  • Le Combattant est un attaquant classique, avec son épée il saura terrasser chacun de ses adversaire.")
            print("  • Le mage est pacificiste, il saura soigner presque toutes les blessures de ses compagnons d'armes.")
            print("  • Le Colosse, est certe lent et peu puissant, mais il est capable de resister à toutes les attaques sans broncher.")
            print("  • Le Nain, cet être est aussi petit qu'il est raleur, mais ne le sous-estimé pas, un coup de hache bien placé et votre vie pourrait être mise à mal.\n" )
            
            for _ in 0...2 { //depends of number of teammates, might be changed by a parameter set with the init.
                
                let characterType = self.selectCharacter()
                let teammate = self.createCharacter(characterType: characterType)
                newGame.characterList.append(teammate)
            }
            
            //create the object with init
            let teamIndex = (teamNumber - 1) *  3 // use it to have a multiple of 3 because there are 3 characters in teams.
            let team = Team(
                teamName: teamName,
                teamNumber: teamNumber,
                teammate1: characterList[0 + teamIndex],
                teammate2: characterList[1 + teamIndex],
                teammate3: characterList[2 + teamIndex]
            )
            
            return team
        }
        
        return teamList[teamNumber - 1]
        
    
    }
    func startGame() {
        print("Les Règles sont les suivantes");
        print("Le joueur numéro 1 va tout d'abord choisir un nom d'équipe. Une fois cela fait il va choisir le type de personnage qu'il souhaite avoir dans son équipe. Chaque équipe doit se constituer de 3 personnages. Pas de restriction quant aux personnage.")
        for i in 1...self.numberOfPlayers! {
            let team = self.createTeam(teamNumber: i)
            teamList.append(team)
        }
        
        //attaquer seulement avec une équipe à la fois
        var playingTeam = 0
        var i = 0
        repeat {
            
            attackAction(team: self.teamList[playingTeam])

            //change the team who will play in the next batch of the loop
            if (playingTeam == 0) {
                playingTeam = 1
            } else {
                playingTeam = 0
            }
            i += 1
        } while (!teamList[0].hasLose && !teamList[1].hasLose)
        
    }
    
    func isNameAvailable(characterName: String) -> Bool {
        var nameAvailable = true

        if self.characterList.count != 0 {
            for teammate in self.characterList {
                if teammate.name == characterName {
                    nameAvailable = false
                }
                return nameAvailable
            }
        }
        return nameAvailable
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
    
    //complete the characters creation.
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
    
    
    func attackAction(team: Team) {
        print("\(team.name ?? "C'est") à toi d'jouer, choisis un de tes personnages.")
        
        var selectedAttacker: Character!
        print("\n"
            + "\n1 \(printCharacterAvailableToAttack(team: team, index: 0))"
            + "\n2 \(printCharacterAvailableToAttack(team: team, index: 1))"
            + "\n3 \(printCharacterAvailableToAttack(team: team, index: 2))"
        )
        
        if let attacker = readLine() {
            switch attacker {
            case "1":
                selectedAttacker = team.teammate1
            case "2":
                selectedAttacker = team.teammate2
            case "3":
                selectedAttacker = team.teammate3
            default:
                attackAction(team: team)
            }
        }
        //Manage the Magus case
        var message = ""
        if (selectedAttacker!.life != 0) {
            var competitorTeamIndex = 1
            if (team.teamNumber == 2) {competitorTeamIndex = 0}
            
            let competitorTeam = teamList[competitorTeamIndex]

            print("Quel personnage de ton adversaire souhaites tu attaquer ?")
            
            var selectedVictim: Character!
            print("\n"
                + "\n1 \(printCompetitorsAlive(team: competitorTeam, index: 0))"
                + "\n2 \(printCompetitorsAlive(team: competitorTeam, index: 1))"
                + "\n3 \(printCompetitorsAlive(team: competitorTeam, index: 2))"
            )
            
            if let victim = readLine() {
                switch victim {
                case "1":
                    selectedVictim = competitorTeam.teammate1
                case "2":
                    selectedVictim = competitorTeam.teammate2
                case "3":
                    selectedVictim = competitorTeam.teammate3
                default:
                    attackAction(team: team)
                }
            }
            
            message = selectedAttacker.attack(opponent: selectedVictim)
        } else {
            print("désolé le personnage n'a plus de vie merci de choisir un personne vivant")
            attackAction(team: team)
        }
        
        print(message)
    }

    func printCharacterAvailableToAttack(team: Team, index: Int) -> String {
        var message: String?
        if (team.teammateList[index].life != 0) {
            message = "\(team.teammateList[index].name) dispose de \(team.teammateList[index].strength) points d'attaque"
        } else {
            message = "\(team.teammateList[index].name) est mort et n'est plus disponible"
        }
        return message!
    }
    
    func printCompetitorsAlive(team: Team, index: Int) -> String {
        var message: String?
        if (team.teammateList[index].life != 0) {
            message = "\(team.teammateList[index].name) dispose de \(team.teammateList[index].life) points de vie"
        } else {
            message = "\(team.teammateList[index].name) est mort et n'est plus disponible"
        }
        return message!
    }
}
