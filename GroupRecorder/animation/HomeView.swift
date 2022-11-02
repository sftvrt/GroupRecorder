//
//  HomeView.swift
//  Bachelorarbeit
//
//  Created by JT X on 09.09.22.
//


import Foundation
import SwiftUI

struct HomeView: View{
    
    @State var startAnimation = false
    @State var pluse1 = false
    @State var pluse2 = false
    @State var foundPeople: [People] = []
    @State var finischAnimation = false
    
    var body: some View {
        
        VStack{
            HStack(spacing:10) {
                Button(action:{}, label: {
                    Image(systemName: "chevron.left").font(.system(size: 22, weight: .semibold)).foregroundColor(.blue)
                })
                
                Text(finischAnimation ? "\(peoples.count) Share" : "Share Search?" ).font(.title2).fontWeight(.bold).foregroundColor(.blue).animation(.none)
                
                Spacer()
                
                Button(action:verifyandAddPeople, label: {
                    if finischAnimation{
                        Image(systemName: "arrow.clockwise").font(.system(size:22, weight: .semibold)).foregroundColor(.blue)
                    }
                })
                .animation(.none)
            }
            .padding()
            .padding(.top, getSafeArea().top)
            .background(Color.white)
            
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
                
                ForEach(foundPeople) {
                    people in Image(people.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(5)
                        .background(Color.white.clipShape(Circle()))
                        .offset(people.offset)
                }
            }
            .frame(maxWidth: .infinity)
            
            if finischAnimation {
                VStack{
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 50, height: 4)
                        .padding(.vertical, 10)
                        
                        
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:15){
                            
                            ForEach(peoples) { people in
                                VStack(spacing:15){
                                    Image(people.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    Text(people.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Button(action: {}, label:  {
                                        Text("Share")
                                            .fontWeight(.semibold)
                                            .padding(.vertical,10)
                                            .padding(.vertical, 40)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    })
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                        .padding(.bottom,getSafeArea().bottom)
                    }
                }
                .background(Color.white)
                .cornerRadius(25)
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
        .background(Color.blue.opacity(0.05).ignoresSafeArea())
        .onAppear(perform: {
            animationView()
        })
    }
    
    func verifyandAddPeople(){
        
        if foundPeople.count < 5 {
            withAnimation{
                var people = peoples[foundPeople.count]
         //       people.offset = firstFiveOffsets[foundPeople.count]
                foundPeople.append(people)
            }
        } else {
            withAnimation(Animation.linear(duration: 0.6)){
                finischAnimation.toggle()
                startAnimation = false
                pluse1 = false
                pluse2 = false
            }
            if !finischAnimation{
                withAnimation{foundPeople.removeAll()}
                animationView()
            }
        }
    }
    
    func animationView(){
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
            startAnimation.toggle()
        }
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
            pluse1.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
                pluse2.toggle()
            }
        }
    }
}

extension View{
    func getSafeArea() -> UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/

