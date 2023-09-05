//
//  HomeView.swift
//  BullsCows
//
//  Created by MAC on 8/31/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = GameViewModel()
    @StateObject var localData:LocalData
    
    @State var str = ""
    @State var showAlertWin = false
    @State var showAlertLose = false
    @State var positionText = CGSize.zero
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            ScrollView(showsIndicators: false) {
                
                Spacer()
                    .frame(height: 70)
                
                
                ForEach(viewModel.numbers) { item in
                    
                    MyText(number: item.number, bulls: item.bulls, cows: item.cows)
                        .padding(.horizontal)
                }
                
                
                Spacer()
                    .frame(height: 100)
            }
            
            VStack {
                
                HStack(alignment: .top){
                    
                    TextField("number", text: $str)
                        .frame(height: 40)
                        .padding(.horizontal)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(15)
                    
                    VStack {
                        Button {
                            check()
                            
                        } label: {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 80,height: 40)
                                
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(width:24)
                            }
                            
                        }
                        .alert("Nice", isPresented: $showAlertWin) {
                            
                            Button("Ok") {
                                viewModel.startAgain()
                                str = ""
                            }
                            
                        } message: {
                            Text("number was \(viewModel.hiddenNumber)")
                        }
                        
                        Text("проверить")
                    }
                    
                    
                    Spacer()
                    
                    Divider()
                        .frame(height: 40)
                    VStack {
                        
                        Button {
                            showAlertLose = true
                            localData.append(win: false, rounds: viewModel.rounds, hiddenNumber: viewModel.hiddenNumber)
                        } label: {
                            
                            Image(systemName: "multiply.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:40)
                                .foregroundColor(.red)
                        }
                        .alert("Try again", isPresented: $showAlertLose) {
                            
                            Button("Ok") {
                                viewModel.startAgain()
                                str = ""
                            }
                            
                        } message: {
                            Text("number was \(viewModel.hiddenNumber)")
                        }
                        
                        Text("сдаться")
                    }
                    
                    
                }
                .padding(.top,10)
                .padding(.horizontal,15)
            }
            .padding(.bottom,15)
            .background(.ultraThinMaterial)
            
            if viewModel.numbers.count == 0 {
                
                VStack {
                    
                    Spacer()
                        .frame(height: 120)
                    
                    HStack() {
                        
                        Text("Write a number to start a game")
                            .font(.custom("AmericanTypewriter-Bold", size: 30))
                            .padding(.horizontal,10)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        
                        Text("'check the rules on 3rd tab rules'")
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                            .padding(.horizontal)
                        
                        Image(systemName: "list.bullet.clipboard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 33,height: 33)
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                }
                .offset(x:positionText.width,y:positionText.height)
                .animation(.spring(response: 0.3,dampingFraction: 0.6,blendDuration: 0),value: positionText)
                .gesture(
                    
                    DragGesture()
                        .onChanged { value in
                            self.positionText = value.translation
                        }
                        .onEnded { value in
                            positionText = .zero
                        }
                )
            }
        }
    }
    
    func check() {
        
        guard viewModel.append(number: str)  else {return}
        
        if str == viewModel.hiddenNumber {
            showAlertWin = true
            localData.append(win: true, rounds: viewModel.rounds, hiddenNumber: viewModel.hiddenNumber)
        }
        else {
            str = ""
        }
    }
}


struct MyText: View {
    
    var number:String
    var bulls:String
    var cows:String
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text(number)
            
            Spacer()
            
            Text("bulls:\(bulls) cows:\(cows)")
            
            Spacer()
        }
        .frame(height: 25)
        .padding()
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 3)
                
        })
        .cornerRadius(10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(localData: LocalData.getTest())
    }
}
