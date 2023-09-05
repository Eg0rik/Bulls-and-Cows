//
//  RulesView.swift
//  BullsCows
//
//  Created by MAC on 9/2/23.
//

import SwiftUI

struct RulesView: View {
    
    @AppStorage("selectedColor") var selectedColor = 0
    @StateObject var localData:LocalData
    
    var body: some View {
        VStack {
            
            Text("Bulls and Cows")
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.black)
            
            
            
            Spacer()
            
            Text("Прaвила:")
                .font(.custom("ArialHebrew", size: 20))
            
            List {
                
                Group {
                    
                    Rule(systemName: "1.square", color: localData.getColor(),rule: "Быки и коровы — логическая игра, в ходе которой за несколько попыток игрок должен определить, что задумал компьютер.")
                    
                    Rule(systemName: "2.circle.fill", color: localData.getColor(), rule: "Число, которое нужно угадать, должно быть 4-значным, используя только цифры от 1 до 9, каждую цифру не более одного раза. Например, 1234 допустимо, 0123 недопустимо, 9877 недопустимо, 9876 допустимо.")
                    
                    Rule(systemName: "3.square", color: localData.getColor(),rule: "Копьютер загадывает число")
                    
                    Rule(systemName: "4.circle.fill", color: localData.getColor(), rule: "Задача отгодать число за наименьшее число попыток")
                    
                    Rule(systemName: "5.circle",color: localData.getColor(),  rule: "Bull(Бык) - это цифра, которая есть в нашем загаданном числе и находится на той же позиции")
                    
                    Rule(systemName: "6.square.fill", color: localData.getColor(), rule: "Cow(корова) - это цифра, которая так же есть в нашем числе, но находится не на своём месте")
                    
                    Rule(systemName: "arrow.clockwise", color: localData.getColor(), rule: "Чтобы проверить число нажмите кнопку 'check'")
                    
                    Rule(systemName: "questionmark.circle.fill", color: localData.getColor(), rule: "или нажми кнопку '?' дабы посмотреть загаданное число")
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
        }
    }
}

struct Rule:View {
    
    var systemName:String
    var color:Color
    var rule:String
    
    var body: some View {
        
        HStack(alignment: .top) {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:40)
                .foregroundColor(color)
                .padding(.top,10)
            
            Text(rule)
                .padding(10)
                .padding(.top,8)
            
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView(localData: LocalData.getTest())
    }
}
