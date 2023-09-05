//
//  StartView.swift
//  BullsCows
//
//  Created by MAC on 9/2/23.
//

import SwiftUI

struct StartView: View {
    @State private var showSplash = false
    
    var body: some View {
        
        ZStack {
            
            if showSplash {
                
                MainView()
            }
            else {
                SplashScreenView()
            }
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                withAnimation {
                    showSplash = true
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
