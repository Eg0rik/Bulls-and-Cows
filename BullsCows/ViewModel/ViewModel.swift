//
//  ViewModel.swift
//  BullsCows
//
//  Created by MAC on 8/31/23.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published private var game = Game()
    
    var hiddenNumber:String { game.hiddenNumber! }
    var rounds:Int { game.rounds}
    var numbers:[MyNumber] { game.writtenNumbers }
    
    
    func isHiddenNumber(number:String) -> Bool {
        number == hiddenNumber
    }
    
    func startAgain() {
        game.startAgain()
    }
    
    func append(number:String) -> Bool {
        game.append(number: number)
    }
}



class LocalData: ObservableObject {
    
    @AppStorage("color") var colorName = "pink"
    
    var colors:[String:Color] = ["pink":Color.pink,"yellow":Color.yellow,"red":Color.red,"green":Color.green,"blue":Color.blue,"cyan":Color.cyan]
    
    func getColor() -> Color {
        colors[colorName]!
    }
    
    
    @Published private(set) var games:[GameForHistory] = [] {
        
        didSet {
            encoder(value: games, forKey: "gamesHistory")
        }
    }
    
    
    func encoder(value:Codable,forKey:String) {
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(value) {
            UserDefaults.standard.set(data, forKey: forKey)
        }
    }
    
    
    
    init() {
        
        if let savedGames = UserDefaults.standard.data(forKey: "gamesHistory")
        {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([GameForHistory].self, from: savedGames) {
                games = decoded
            } else {
                print("error games 2")
            }
        } else {
            print("error games 1")
        }
        
    }
    
    func append(win:Bool,rounds:Int,hiddenNumber:String) {
        games.append(GameForHistory(idGame: games.count, win: win, rounds: rounds, hiddenNumber: hiddenNumber))
    }
    
    
    func lastGames(last:String) -> [GameForHistory ]{
        
        guard games.count >= 7 else {return games}
        
        if last == "7 games" {
            return  Array(games.dropFirst(games.count - 7))
        }
        
        return Array(games.dropFirst(games.count - 15))
    }
    
    
    func createNewArray() {
        
        games = []
        
        for i in 0..<20 {
            games.append(GameForHistory(idGame: i, win: i % 2 == 0 ? true : false, rounds: (2...30).randomElement()!, hiddenNumber: String(1230 + i)))
        }
    }
    
    
    func clear() {
        games = []
    }
    
    
    static func getTest() -> LocalData {
        
        let data = LocalData()
        data.createNewArray()
        return data
    }
}
