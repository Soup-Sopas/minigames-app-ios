//
//  GridGameView.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 15/12/23.
//

import SwiftUI

struct GridGameView: View {
    
    @StateObject var vM = GridGameViewModel()
    
    @Binding var isFlagModeActive: Bool
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: vM.columns, spacing: 0, content: {
                ForEach(0..<(7 * 10), content: { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundStyle(vM.alternateBox(cell: i) ? .box1 : .box2)
                            .overlay(
                                Rectangle()
                                    .foregroundStyle(.uncover)
                                    .opacity(vM.cells[i]?.uncover ?? false ? 1 : 0)
                                    .shadow(radius: 5)
                                    .animation(.spring(duration: 0.5), value: vM.cells[i]?.uncover)
                            )
                        
                        if vM.bombs.contains(i) {
                            Image("bomb")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .opacity(vM.showBombs ? 1 : 0)
                                .animation(.easeInOut(duration: 1), value: vM.isAlertActive)
                        }
                        
                        Image(vM.cells[i]?.flagImage ?? "")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(vM.showBombs ? 0 : 1)
                        
                    }
                    .onTapGesture {
                        // Toggles Flag Mode
                        if isFlagModeActive {
                            if vM.cells[i] == nil { vM.cells[i] = Cell(index: i, uncover: false) }
                            if vM.cells[i]?.uncover ?? false { return }
                            vM.cells[i]?.isFlagShown.toggle()
                            return
                        }
                        
                        // Process the move
                        vM.processMove(for: i)
                    }
                   
                })
            })
            .background(.white)
            .overlay(
                Rectangle()
                    .inset(by: -8)
                    .strokeBorder(.black, lineWidth: 8)
            )
            .disabled(vM.isAlertActive)
           
            
            if vM.isAlertActive {
                CustomAlerts(isActive: $vM.isAlertActive, title: vM.title, buttonTitle: "Play Again", action: { vM.resetGame() })
            }

        }
    }
}


#Preview {
    GridGameView(isFlagModeActive: .constant(false))
}
