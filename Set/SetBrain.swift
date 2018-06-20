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
    var points = 0
    var cardsFacedUp = [Card]()
    
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
        
        shuffleCards()
        
    }
    
    func chechForMatch() {
        
        //one of the 4 categories all the same
        
        //all have same color
        //all have same shading
        //all have same count
        //all have same shape
        
        //all the 4 categories are different
        
        //all have different color
        //all have different shading
        //all have different count
        //all have differeht shape
        
    }
    
    mutating private func shuffleCards() {
        
        for i in cardsArray.indices {
            
            let randomNum = cardsArray.count.arc4random
            let temp = cardsArray[randomNum]
            cardsArray[randomNum] = cardsArray[i]
            cardsArray[i] = temp
            
        }
        
    }
}

