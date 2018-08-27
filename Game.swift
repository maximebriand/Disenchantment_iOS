
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
//    
//    func attackAction(team: Team) {
//        print("\(team.name) à toi d'jouer, choisis un de tes personnages.")
//        printAliveCharacter(team: team)
//        
//        var selectedAttacker = Character()
//        
//        if let attacker = readLine() {
//            switch characterChoise {
//            case "1":
//                selectedCharacter = team.teammate1
//            case "2":
//                selectedCharacter = team.teammate2
//            case "3":
//                selectedCharacter = team.teammate3
//            default:
//                attackAction(team)
//            }
//        }
//        
//
//
//
//
//    }
//
//    func printAliveCharacter(team: Team) {
//
//        print("
//            + "\n"
//            + "\n1 \(team.teammate1.name"
//            + "\n2 \(team.teammate2.name"
//            + "\n3 \(team.teammate3.name")
//    }
    
    
    
}
