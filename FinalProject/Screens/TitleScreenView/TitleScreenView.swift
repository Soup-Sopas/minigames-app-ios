//
//  ContentView.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 12/12/23.
//

import SwiftUI

struct TitleScreenView: View {
    
    @State var animation1 = false
    @State var animation2 = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 20)
                
                TitleView()
                
                Spacer().frame(height: 160)
                
                
                NavigationLink(destination: MinesweeperView().navigationBarBackButtonHidden(true), label: {
                    SelectGameView(gameTitle: "Minesweeper")
                })
                
                Spacer().frame(height: 50)
                
                NavigationLink(destination: TicTacToeView().navigationBarBackButtonHidden(true), label: {
                    SelectGameView(gameTitle: "Tic-Tac-Toe")
                })
                
                Spacer()
                
                VStack {
                    HStack(spacing: 20) {
                        DotsLine()
                            .offset(CGSize(width: animation1 ? 470 : -190, height: 0))
                            .animation(.linear(duration: 7).repeatForever(autoreverses: false).delay(3.5), value: animation1)
                        
                        DotsLine()
                            .offset(CGSize(width: animation2 ? 190 : -470, height: 0))
                            .animation(.linear(duration: 7).repeatForever(autoreverses: false), value: animation2)
                    }
                    .shadow(radius: 5)
                    .padding(.top)
                    
                    
                }
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        animation1.toggle()
                        animation2.toggle()
                        
                    }
                })
            }
                
        }
    }
}

#Preview {
    TitleScreenView()
}

struct TitleView: View {
    var body: some View {
        Text("Minigames")
            .font(.system(size: 50, weight: .bold, design: .monospaced))
            .foregroundStyle(.black)
            .kerning(3)
            .accessibilityAddTraits(.isHeader)
            .padding(.top, 20)
            .overlay(
                Rectangle()
                    .trim(from: 0.5, to: 0.88)
                    .offset(CGSize(width: 0, height: 10))
                    .stroke(lineWidth: 6.0)
                    .foregroundStyle(.green)
                    .frame(width: 350,height: 100)
                
            )
    }
}

struct DotsLine: View {
    var body: some View {
        ForEach(0..<4, content: { i in
            Circle()
                .frame(width: 50,height: 50)
            
        })
    }
}
