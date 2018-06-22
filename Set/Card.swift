//
//  Card.swift
//  Set
//
//  Created by ARNAV SINGHANIA on 6/18/18.
//  Copyright © 2018 Kay Bee Development. All rights reserved.
//

import Foundation

struct Card: Equatable {
    
    let number: CardNumber
    let symbol: CardSymbol
    let shading: CardShading
    let color: CardColor
    var isSelected = false
    
    enum CardNumber: Int {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum CardSymbol: Int {
        case triangle = 1
        case circle = 2
        case square = 3
        
    }
    
    enum CardShading: Int {
        case solid = 1
        case open = 2
        case striped = 3
    }
    
    enum CardColor: Int {
        case red = 1
        case magenta = 2
        case black = 3
    }
    
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.number == rhs.number && lhs.color == rhs.color && lhs.shading == rhs.shading && lhs.symbol == rhs.symbol)
    }
    
}
