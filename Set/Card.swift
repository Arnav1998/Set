//
//  Card.swift
//  Set
//
//  Created by ARNAV SINGHANIA on 6/18/18.
//  Copyright © 2018 Kay Bee Development. All rights reserved.
//

import Foundation

struct Card {
    
    let number: CardNumber
    let symbol: CardSymbol
    let shading: CardShading
    let color: CardColor
    
    enum CardNumber: Int {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum CardSymbol: String {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
    }
    
    enum CardShading {
        case solid
        case open
        case striped
    }
    
    enum CardColor {
        case red
        case green
        case yellow
    }
    
}
