//
//  AnalyticsView.swift
//  BullsCows
//
//  Created by MAC on 8/31/23.
//

import SwiftUI
import Charts

struct AnalyticsView: View {
    
    @StateObject var localData:LocalData
    @State var animate = false
    @State var areaMark = false
    @State var currentTab = "7 games"
    
    var max:Int {
        localData.games.max(by: {$0.rounds < $1.rounds})?.rounds ?? 90 + 16
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    HStack {
                        
                        Toggle(isOn: $areaMark) {
                            
                            Text("Line graph")
                        }
                        .padding()
                        .onChange(of: areaMark) { _ in
                            animate = false
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        }
                        .padding(.horizontal)
                        
                        Button("example") {
                            localData.createNewArray()
                        }
                        .frame(height: 65)
                        .padding(.horizontal,10)
                        .background {
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        }
                        
                        Button("clear") {
                            localData.clear()
                        }
                        .frame(height: 65)
                        .padding(.horizontal,10)
                        .background {
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("статистика последих игр, сколько чисел понадобилось дабы угадать число")
                                .font(.system(size: 13))
                                .padding(.bottom,10)
                            
                            
                            HStack(spacing:90) {
                                
                                Text("Last")
                                    .fontWeight(.semibold)
                                
                                Picker("",selection: $currentTab.animation()) {
                                    
                                    Text("7 Games")
                                        .tag("7 games")
                                    Text("15 Games")
                                        .tag("15 games")
                                }
                                .pickerStyle(.segmented)
                            }
                            
                        }
                        
                        if areaMark {
                            createAreaMark()
                        } else {
                            createBarMark()
                        }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .fill(.white.shadow(.drop(radius: 2)))
                    }
                    .padding()
                    
                    if !areaMark {
                        HStack {
                            Spacer()
                            
                            Circle()
                                .fill(.red)
                                .frame(width:15)
                            
                            Text(" - сдался")
                            
                            Spacer()
                            
                            Circle()
                                .fill(.green)
                                .frame(width:15)
                            
                            Text(" - угадал")
                            
                            Spacer()
                        }
                        .padding([.top,.bottom],10)
                        .background {
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        }
                        .padding(.horizontal)
                    }
                    
                }
                Spacer()
                    .frame(height: 200)
            }
            .navigationTitle("Analytics")
        }
    }
    
    func createAreaMark() -> some View {
        
        Chart(localData.lastGames(last: currentTab)) { item in
            
            LineMark(x: .value("game", String(item.idGame)), y: .value("rounds", animate ? item.rounds : 0))
                .foregroundStyle(.blue)
            
            AreaMark(x: .value("game", String(item.idGame)), y: .value("rounds", animate ? item.rounds : 0))
                .foregroundStyle(.blue.opacity(0.3))
            
        }
        .chartYScale(domain: 0...(max+5))
        .frame(height: 300)
        .onAppear {
            
            withAnimation {
                animate = true
            }
        }
    }
    
    
    func createBarMark() -> some View {
        
        Chart(localData.lastGames(last: currentTab)) { item in
            
            BarMark(x: .value("game", String(item.idGame)), y: .value("rounds", animate ? item.rounds : 0))
                .foregroundStyle(item.win ? Color.green.gradient : Color.red.gradient)
                .annotation(position: .top) {
                    Text(String(item.rounds))
                        .font(.system(size: 12))
                }
            
        }
        .chartYScale(domain: 0...(max+5))
        .frame(height: 300)
        .onAppear {
            withAnimation {
                animate = true
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView(localData: LocalData.getTest())
    }
}
