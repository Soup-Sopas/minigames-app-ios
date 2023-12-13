//
//  MinesweeperSelectView.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 22/12/23.
//

import SwiftUI

struct SelectGameView: View {
    
    var gameTitle: String
    var color1 = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var color2 = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    var width: CGFloat = 300
    var height: CGFloat = 100
    var percent: CGFloat = 7

    
    var body: some View {
        let multiplier = width / 44

            return ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: multiplier))
                    .frame(width: width, height: height)
                
                Text(gameTitle)
                    .font(.title.bold())
                    .kerning(5)
                    .foregroundColor(.black)

                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .trim(from: 0.48, to: 0.52)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .leading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 2 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
                    .frame(width: width, height: height)
            }
    }
}

#Preview {
    SelectGameView(gameTitle: "Minesweeper")
}

//                .trim(from: show ? 0.10 : 0.48, to: 0.40 : 0.52)

