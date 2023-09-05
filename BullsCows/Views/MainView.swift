//
//  MainView.swift
//  BullsCows
//
//  Created by MAC on 8/31/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    
    case house
    case statics
    case rules
    case settings
}

struct MainView: View {
    
    @State var selectedTab = "Home"
    @State var tabBar = true
    @StateObject var localData = LocalData()
    
    init() {

        UITabBar.appearance()
            .isHidden = true
    }
    
    var body: some View {
        
        VStack {
            
            TabView(selection: $selectedTab) {
                
                AnalyticsView(localData: localData)
                    .tag("Statistics")
                
                HomeView(localData: localData)
                    .tag("Home")
                
                RulesView(localData: localData)
                    .tag("Rules")
                
                SettingsView(localData: localData)
                    .tag("Settings")
            }
            
            CustomTabBar(selectedTab: $selectedTab,localData: localData)
        }
    }
}


struct CustomTabBar: View {
    
    @Binding var selectedTab:String
    @StateObject var localData:LocalData
    
    var body: some View {
        
        VStack {
            
            
            HStack {
                
                Spacer()
                TabBarItem(nameTab: "Home",selectedTab: $selectedTab,imageName: "house.fill")
                Spacer()
                TabBarItem(nameTab: "Statistics",selectedTab: $selectedTab,imageName: "chart.bar.fill")
                Spacer()
                TabBarItem(nameTab: "Rules",selectedTab: $selectedTab,imageName: "list.bullet.clipboard")
                Spacer()
                TabBarItem(nameTab: "Settings",selectedTab: $selectedTab,imageName: "gear")
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: 70)
            .background(.ultraThinMaterial)
            .background(
                
                HStack {
                    
                    if selectedTab == "Settings" {Spacer()}
                    if selectedTab == "Rules" {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == "Statistics" {Spacer()}
                    
                    Circle()
                        .fill(localData.getColor())
                        .frame(width:80)
                    
                    if selectedTab == "Home" {Spacer()}
                    if selectedTab == "Statistics" {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == "Rules" {
                        Spacer()
                    }
                }
                .padding(.horizontal,30)
            )
            .overlay {
                
                VStack {
                    
                    HStack {
                        
                        if selectedTab == "Settings" {Spacer()}
                        if selectedTab == "Rules" {
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == "Statistics" {Spacer()}
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:60,height: 7)
                        
                        if selectedTab == "Home" {Spacer()}
                        if selectedTab == "Statistics" {
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == "Rules" {
                            Spacer()
                        }
                    }
                    .padding(.horizontal,40)
                    
                    Spacer()
                }
            }
        }
    }
}

struct TabBarItem: View {
    
    var nameTab:String
    @Binding var selectedTab:String
    var imageName:String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Button {
                withAnimation {
                    selectedTab = nameTab
                }
            } label : {
                
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 33,height: 33)
                    .foregroundColor(.black.opacity(nameTab == selectedTab ?  1 : 0.6))
                    .rotationEffect(.degrees((nameTab == selectedTab && nameTab == "Settings" ) ? 10 : 0))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
