//
//  Model.swift
//  BullsCows
//
//  Created by MAC on 8/31/23.
//

import Foundation
import SwiftUI

struct MyNumber:Identifiable,Codable { //the number that the user enters
    
    var id = UUID()
    let number:String
    let bulls:String // bulls in number
    let cows:String // cows in number
}


struct GameForHistory: Identifiable,Codable {
    
    var id = UUID()
    let idGame:Int
    let win:Bool // won or surrendered
    let rounds:Int // == writtenNumbers.count
    let hiddenNumber:String
    //let writtenNumbers:[MyNumber] // user-entered numbers
}

protocol GameProtocol {
    
    var hiddenNumber:String! { get set } // the number to guess
    var rounds:Int { get set }// == writtenNumbers.count
    var writtenNumbers:[MyNumber] { get set }// user-entered numbers
    
    mutating func append(number:String) -> Bool // запомнить введенное число
    mutating func startAgain() // начать заново
    func isRightNumber (number:String) -> Bool  // проверка введенно ли коректное число
    func checkBullsCows(number:String) -> (bulls:Int,cows:Int)  // число быков и коров введенного коректного числа
    mutating func createHiddenNumber() -> String  // создать рандомное четырехзначное число без повтора цифа и первого нуля
    
    static func getTest() -> Game
}

struct Game: GameProtocol {
    
    var hiddenNumber:String!
    var rounds:Int
    var writtenNumbers:[MyNumber]
    
    
    init() {
        rounds = 0
        writtenNumbers = []
        hiddenNumber = createHiddenNumber()
    }
    
    mutating func append(number:String) -> Bool {
        
        if isRightNumber(number: number) {
            
            let bulls_and_cows:(bulls:Int,cows:Int) = checkBullsCows(number: number)
            writtenNumbers.append(MyNumber(number: number, bulls: String(bulls_and_cows.bulls), cows: String(bulls_and_cows.cows)))
            rounds += 1
            
            return true
        }
        
        return false
    }
    
    
    mutating func startAgain() {
        
        rounds = 0
        writtenNumbers = []
        hiddenNumber = createHiddenNumber()
    }
    
    
    func checkBullsCows(number:String) -> (bulls:Int,cows:Int) { // число быков и коров введенного коректного числа
        
        var answer = (bulls:0,cows:0)
        
        for i in number.indices {
            if number[i] == hiddenNumber[i] {
                answer.bulls += 1
            }
        }
        
        for char in number {
            if hiddenNumber.contains(char) {
                answer.cows += 1
            }
        }
        
        answer.cows -= answer.bulls
        
        return answer
    }
    
    
    func isRightNumber (number:String) -> Bool { // проверка введенно ли коректное число
        
        guard number.count == 4 else {return false}
        guard (Int(number) != nil) else {return false}
        guard number.first != "0" else {return false}
        
        var st:Set<Int> = [0,1,2,3,4,5,6,7,8,9]
        
        for char in number {
            if st.remove(Int(String(char))!) == nil {return false}
        }
        
        return true
    }
    
    
    mutating func createHiddenNumber() -> String { // create a random four-digit number without repeating digits and the first zero
        
        var st:Set<Int> = [0,1,2,3,4,5,6,7,8,9]
        var number:[String] = []
        
        for _ in 0..<4 {
            
            let randomInSet = st.randomElement()!
            number.append(String(randomInSet))
            st.remove(randomInSet)
        }
        
        if number[0] == "0" {
            number[0] = String(st.randomElement()!)
        }
        
        return number.joined()
    }
    
    
    
    static func getTest() -> Game {
        
        var game = Game()
       
        for i in 0..<10 {
            game.writtenNumbers.append(MyNumber(number: String(i+1000), bulls: String(i), cows: String(i)))
        }
        game.rounds = game.writtenNumbers.count
        
        return game
    }
}
