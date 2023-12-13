//
//  CustomAlerts.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 20/02/24.
//

import SwiftUI

struct CustomAlerts: View {
    
    @Binding var isActive: Bool
    let title: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .bold()
            .padding()
            
            HStack {
                NavigationLink(destination: {
                    TitleScreenView().navigationBarBackButtonHidden(true)
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.cyan)
                        
                        Text("Go Back")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                            .padding()
                    }
                })
                
                Button {
                    close()
                    action()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.purple)
                        
                        Text(buttonTitle)
                            .font(.body.bold())
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 20)
        .padding(30)
        .offset(x: 0, y: offset)
        .onAppear {
            withAnimation(.spring()) {
                offset = 0
            }
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

#Preview {
    CustomAlerts(isActive: .constant(true), title: "You Win!", buttonTitle: "Play Again", action: {})
}
