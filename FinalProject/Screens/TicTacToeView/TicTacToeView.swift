//
//  TicTacToeView.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 19/12/23.
//

import SwiftUI

struct TicTacToeView: View {
    
    @StateObject private var vM = TicTacToeViewModel()
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        Spacer()
                        LazyVGrid(columns: vM.columns, content: {
                            ForEach(0..<9, content: { i in
                                TicTacToeGridGameView(proxy: geometry, systemImageName: vM.moves[i]?.symbol ?? "")
                                    .shadow(radius: 3)
                                .onTapGesture {
                                    vM.processMove(for: i)
                                }
                            })
                        })
                        Spacer().frame(height: 100)
                    }
                    .disabled(vM.isBoardDisabled)
                    .padding()
                    
                    returnView()
                        .shadow(radius: 8)
                    
                }
            }
            .blur(radius: vM.isAlertActive ? 2: 0)
            
            if vM.isAlertActive {
                CustomAlerts(isActive: $vM.isAlertActive, 
                             title: vM.alertItem!.title,
                             buttonTitle: vM.alertItem!.buttonTitle,
                             action: { vM.resetGame() })
            }
        }
    }

}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let index: Int
    var symbol: String {
        return player == .human ? "xmark" : "circle"
    }
}

#Preview {
    TicTacToeView()
}

struct returnView: View {
    var body: some View {
        NavigationLink(destination: TitleScreenView().navigationBarBackButtonHidden(true), label: {
            RotatedShape(shape: .buttonBorder, angle: .degrees(45))
                .frame(width: 100, height: 100)
                .foregroundStyle(.black)
                .overlay {
                    Image(systemName: "arrowshape.backward.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                    
                    RotatedShape(shape: .buttonBorder, angle: .degrees(45))
                        .inset(by: 5)
                        .strokeBorder(.white, lineWidth: 4)
                }
                .padding(.bottom, 20)
        })
    }
}

struct TicTacToeGridGameView: View {
    
    var proxy: GeometryProxy
    var systemImageName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: abs(proxy.size.width/3 - 15), height: abs(proxy.size.width/3 - 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 5)
                        .strokeBorder(.white, lineWidth: 4)
                )
            
            Image(systemName: systemImageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.white)
        }
    }
}
