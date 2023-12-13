//
//  MinesweeperView.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 15/12/23.
//

import SwiftUI

struct MinesweeperView: View {
    
    @State var isFlagModeActive: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                
                GridGameView(isFlagModeActive: $isFlagModeActive)
                
                Spacer()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 360, height: 120)
                        .foregroundStyle(.ultraThickMaterial).shadow(radius: 10)
                    
                    HStack {
                        Spacer().frame(width: 50)
                        NavigationLink(destination: TitleScreenView().navigationBarBackButtonHidden(true), label: {
                            RotatedShape(shape: .buttonBorder, angle: .degrees(45))
                                .frame(width: 60, height: 60)
                                .foregroundStyle(.box1)
                                .overlay {
                                    Image(systemName: "arrowshape.backward.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.white)
                                    
                                    RotatedShape(shape: .buttonBorder, angle: .degrees(45))
                                        .inset(by: 5)
                                        .strokeBorder(.white, lineWidth: 4)
                                }
                                .shadow(radius: 5)
                        })
                        Spacer()
                        Button(action: {
                            isFlagModeActive.toggle()
                        }, label: {
                            Image("flag")
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                        .frame(width: 70, height: 70)
                        .background(
                            ZStack {
                                Color(isFlagModeActive ? .box2 : .clear).clipShape(RoundedRectangle(cornerRadius: 6))
                                RoundedRectangle(cornerRadius: 6)
                                    .inset(by: 0)
                                    .strokeBorder(.black, lineWidth: 4)
                            }
                                
                        )
                        .shadow(radius: 2)
                        Spacer().frame(width: 50)
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    MinesweeperView()
}
