//
//  showAnimation.swift
//  Bachelorarbeit
//
//  Created by JT X on 15.09.22.
//

import SwiftUI

struct showAnimation: View {
    @State var startAnimation = false
    @State var pluse1 = false
    @State var pluse2 = false
    @State var finischAnimation = false
    
    var body: some View {
     
        VStack{
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.6))
                .frame(width: 130, height: 130)
                .scaleEffect(pluse1 ? 3.3:0)
                .opacity(pluse1 ? 0:1)
            
            Circle()
                .stroke(Color.gray.opacity(0.6))
                .frame(width: 130, height: 130)
                .scaleEffect(pluse1 ? 3.3:0)
                .opacity(pluse1 ? 0:1)
            
            Circle()
                .fill(Color.white)
                .frame(width: 130, height: 130)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
            
            Circle()
               // .stroke(Color("Color1"), lineWidth: 1.4)
                .stroke(Color.green, lineWidth: 1.4)
                .frame(width: finischAnimation ? 70:30, height: finischAnimation ? 70:30)
                .overlay(Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .opacity(finischAnimation ? 1:0)
                )
                
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.4)
                   // .stroke(Color("Color1"), lineWidth: 1.4)
                    .stroke(Color.green, lineWidth: 1.4)
                Circle()
                    .trim(from: 0, to: 0.4)
                    //.stroke(Color("Color1"), lineWidth: 1.4)
                    .stroke(Color.green, lineWidth: 1.4)
                    .rotationEffect(.init(degrees: -180))
            }
            .frame(width: 70, height: 70)
            .rotationEffect(.init(degrees: startAnimation ? 360:0))
        }
    } .background(Color.blue.opacity(0.05))
    }
}

/*
struct showAnimation_Previews: PreviewProvider {
    static var previews: some View {
        showAnimation()
    }
}
*/
