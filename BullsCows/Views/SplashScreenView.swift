//
//  SplashScreenView.swift
//  BullsCows
//
//  Created by MAC on 9/2/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var scale = 0.8
    @State var opacity = 0.5
    @State var xOffset = CGFloat(-30)
    
    var body: some View {
        
        ZStack {
             
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image(systemName: "figure.archery")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:80)
                    .padding(.bottom,19)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                Text("Bulls and Cows")
                    .font(.title)
                    .opacity(opacity)
                    .offset(x: xOffset)
            }
            .foregroundColor(.white)
        }
        .onAppear {
            
            withAnimation(.easeIn(duration: 0.7)) {
                scale = 1
                opacity = 1
                xOffset = 0
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
