//
//  Alerts.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 19/02/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let buttonTitle: String
}

struct AlertContext {
    static let humanWin = AlertItem(title: "You Win!", message: "You are awesome", buttonTitle: "Play Again")
    
    static let computerWin = AlertItem(title: "You Lost", message: "You are not awesome", buttonTitle: "Rematch")
    
    static let draw = AlertItem(title: "Draw", message: "You are okay", buttonTitle: "Try Again")
}

