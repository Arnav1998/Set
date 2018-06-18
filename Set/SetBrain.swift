//
//  SetBrain.swift
//  Set
//
//  Created by ARNAV SINGHANIA on 6/18/18.
//  Copyright © 2018 Kay Bee Development. All rights reserved.
//

import Foundation

struct SetBrain {
    
    var cardsArray = [Card]()
    
    mutating func generateCards() {
        
        for color in 1...3 {
            
            for shading in 1...3 {
                
                for number in 1...3 {
                    
                    for symbol in 1...3 {
                        
                        let card = Card(number: Card.CardNumber(rawValue: number)!, symbol: Card.CardSymbol(rawValue: symbol)!, shading: Card.CardShading(rawValue: shading)!, color: Card.CardColor(rawValue: color)!)
                        
                        cardsArray.append(card)
                        
                    }
                }
                
            }
            
        }
        
    }
    
}
