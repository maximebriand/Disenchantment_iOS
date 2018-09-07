
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

    func startGame() {
        print("Les Règles sont les suivantes");
        print("Le joueur numéro 1 va tout d'abord choisir un nom d'équipe. Une fois cela fait il va choisir le type de personnage qu'il souhaite avoir dans son équipe. Chaque équipe doit se constituer de 3 personnages. Pas de restriction quant aux personnage.")
        for i in 1...self.numberOfPlayers! {
            let team = self.setupTeam(teamNumber: i)
            self.teamList.append(team)
        }
        attackTeamByTeam()
        let winnerTeam = self.winnerTeam()
        print("Bravo \(winnerTeam.name!) tu as gagné ! ")
    }
    
    func printStartingText() {
        print("\n  • Le Combattant est un attaquant classique, avec son épée il saura terrasser chacun de ses adversaire.")
        print("  • Le mage est pacificiste, il saura soigner presque toutes les blessures de ses compagnons d'armes.")
        print("  • Le Colosse, est certe lent et peu puissant, mais il est capable de resister à toutes les attaques sans broncher.")
        print("  • Le Nain, cet être est aussi petit qu'il est raleur, mais ne le sous-estimé pas, un coup de hache bien placé et votre vie pourrait être mise à mal.\n" )
    }
    
    func setupTeam(teamNumber: Int) -> Team {
        print("Personnage \(teamNumber) quel est le nom de votre équipe ?")
        if let teamName = readLine() {
            printStartingText()
            for _ in 0...2 { //depends of number of teammates, might be changed by a parameter set with the init.
                
                let characterType = self.selectCharacter()
                let teammate = self.createCharacter(characterType: characterType)
                newGame.characterList.append(teammate)
            }
            //create the object with init
            let team = createTeam(teamNumber: teamNumber, teamName: teamName)
            return team
        }
        return self.teamList[teamNumber - 1]
    }
    
    func changeTeam(indexTeam: Int) -> Int {
        //change the team who will play in the next batch of the loop
        var playingTeam = indexTeam

        if (playingTeam == 0) {
            playingTeam = 1
        } else {
            playingTeam = 0
        }
        return playingTeam
    }
    
    func attackTeamByTeam() {
        var playingTeam = 0
   
        while (self.teamList[0].hasLose == false && self.teamList[1].hasLose == false){
            self.attackAction(team: self.teamList[playingTeam])
            self.isAWinner()
            
            playingTeam = changeTeam(indexTeam: playingTeam)
        }
    }
    
    func createTeam (teamNumber: Int, teamName: String) -> Team {
        let teamIndex = (teamNumber - 1) *  3 // use it to have a multiple of 3 because there are 3 characters in teams.
        let team = Team(
            teamName: teamName,
            teamNumber: teamNumber,
            teammate1: self.characterList[0 + teamIndex],
            teammate2: self.characterList[1 + teamIndex],
            teammate3: self.characterList[2 + teamIndex]
        )
        return team
    }
    
    func isNameAvailable(characterName: String) -> Bool {
        var nameAvailable = true
        
        if (characterList.contains(where: {$0.name == characterName})) {
            nameAvailable = false
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
    
    func selectACharacter(team: Team, action: printAction) -> Character {
        var selectedCharacter: Character!
        print("\n"
            + "\n1 \(selectPrintAction(team: team, index: 0, action: action))"
            + "\n2 \(selectPrintAction(team: team, index: 1, action: action))"
            + "\n3 \(selectPrintAction(team: team, index: 2, action: action))"
        )
        
        if let target = readLine() {
            switch target {
            case "1":
                selectedCharacter = team.teammate1
            case "2":
                selectedCharacter = team.teammate2
            case "3":
                selectedCharacter = team.teammate3
            default:
                attackAction(team: team)
            }
        }
        return selectedCharacter
    }
    func attackAction(team: Team) {
        let selectedAttacker = selectAttacker(team: team)

        var message = ""
        //if the character has life and is not a magus
        if (selectedAttacker.isDead == false && selectedAttacker.type != .Magus) {
            var competitorTeamIndex = 1
            if (team.teamNumber == 2) {competitorTeamIndex = 0}
            
            let competitorTeam = teamList[competitorTeamIndex]

            print("Quel personnage de ton adversaire souhaites tu attaquer ?")
            
            let selectedVictim = selectACharacter(team: competitorTeam, action: .competitorsAlive)
            
            if (selectedVictim.isDead == false) {
                message = selectedAttacker.attack(opponent: selectedVictim)
            } else {
                print("Désolé mais \(selectedVictim.name) est mort, merci de respecter sa dépouille.")
                attackAction(team: team)
            }
          //if it is a magus
        } else if (selectedAttacker.isDead == false && selectedAttacker.type == .Magus) {
            var selectedTeammate: Character!
            
            print("Quel personnage souhaites tu soigner ?\n"
                + "\n1 \(printCompetitorsAlive(team: team, index: 0))"
                + "\n2 \(printCompetitorsAlive(team: team, index: 1))"
                + "\n3 \(printCompetitorsAlive(team: team, index: 2))"
            )
            
            if let patient = readLine() {
                switch patient {
                case "1":
                    selectedTeammate = team.teammate1
                case "2":
                    selectedTeammate = team.teammate2
                case "3":
                    selectedTeammate = team.teammate3
                default:
                    attackAction(team: team)
                }
            }
            
            if (selectedTeammate.isDead == false) {
                message = selectedTeammate.beTreated(teammate: selectedAttacker)
            } else {
                print("Désolé mais \(selectedTeammate.name) est mort, merci de respecter sa dépouille.")
                attackAction(team: team)
            }
        }
        else {
            print("désolé le personnage n'a plus de vie merci de choisir un personne vivant")
            attackAction(team: team)
        }
        
        print(message)
    }

    func selectAttacker(team: Team) -> Character {
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
        return selectedAttacker
    }
    
    func selectPrintAction(team: Team, index: Int, action: printAction) -> String {
        var message: String
        switch action {
        case .availableToAttack:
            message = printCharacterAvailableToAttack(team: team, index: index)
        case .competitorsAlive:
            message = printCompetitorsAlive(team: team, index: index)
        }
        return message
    }
    
    enum printAction {
        case availableToAttack, competitorsAlive
    }
    
    func printCharacterAvailableToAttack(team: Team, index: Int) -> String {
        var message: String?
        if (team.teammateList[index].life != 0) {
            message = "\(team.teammateList[index].name), un \(team.teammateList[index].type), dispose de \(team.teammateList[index].strength) points d'attaque"
        } else {
            message = "\(team.teammateList[index].name) est mort et n'est plus disponible"
        }
        return message!
    }
    
    func printCompetitorsAlive(team: Team, index: Int) -> String {
        var message: String?
        if (team.teammateList[index].life != 0) {
            message = "\(team.teammateList[index].name), un \(team.teammateList[index].type),  dispose de \(team.teammateList[index].life) points de vie"
        } else {
            message = "\(team.teammateList[index].name) est mort et n'est plus disponible"
        }
        return message!
    }
    
    func isAWinner() {
        for i in  0...1  {
            if (self.teamList[i].teammate1.isDead == true && self.teamList[i].teammate2.isDead == true && self.teamList[i].teammate3.isDead == true )
            {
                self.teamList[i].hasLose = true
            }
        }
    }
    
    func winnerTeam() -> Team {
        var winner: Team?
        for i in  0...1  {
            if (self.teamList[i].hasLose == true) {
                
                winner = self.teamList[changeTeam(indexTeam: i)]
            }
        }
        return winner!
    }
}
