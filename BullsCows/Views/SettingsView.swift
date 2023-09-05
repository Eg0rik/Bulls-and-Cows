//
//  SettingsView.swift
//  BullsCows
//
//  Created by MAC on 9/2/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var localData:LocalData
    @AppStorage("first name") var firstName:String = ""
    @AppStorage("last name") var lastName:String = ""
    
    @State var scale = 1.0
    @State var date = Date()
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section {
                    HStack {
                        
                        VStack {
                            TextField("First name", text: $firstName)
                            TextField("Last name", text: $lastName)
                        }
                        
                        ZStack {
                            
                            Circle()
                                .fill(localData.getColor())
                                .frame(width:55)
                                .overlay(
                                    
                                    Circle()
                                        .stroke(localData.getColor())
                                        .scaleEffect(scale)
                                        .opacity(2 - scale)
                                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: scale)
                                        .onAppear {
                                            scale = 2
                                        }
                                )
                                
                            
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:25)
                            
                        }
                    }
                }
                
                Section {
                    DatePicker("Birthday", selection: $date,displayedComponents: .date)
                    
                    Picker(selection: $localData.colorName,label:Text("")) {
                        
                        ForEach(Array(localData.colors.keys),id: \.self) { key in
                            Text(key)
                                .tag(key)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                

                Section(header: Text("about developer")) {
                    
                    Group {
                        
                        HStack {
                            
                            Link("LeetCode", destination: URL(string: "https://leetcode.com/Eg0rik/")!)
                            
                            Spacer()
                            
                            Image("GitHub-Mark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                        }
                        
                        HStack {
                            
                            Link("GitHub", destination: URL(string: "https://github.com/Eg0rik")!)
                            
                            Spacer()
                            
                            Image("leetcode")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                        }
                    }
                    .foregroundColor(localData.getColor())
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(localData: LocalData.getTest())
    }
}
