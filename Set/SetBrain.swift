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
    var cardsFacedUp: [Card] {
        
        get {
            
            var cards = [Card]()
            
            for i in cardsArray.indices {
                if (cardsArray[i].isSelected) {
                    cards.append(cardsArray[i])
                }
            }

            return cards
        }
        
    }
    
    mutating func generateCards() {
        
        for color in 1...3 {
            
            for shading in 1...3 {
                
                for number in 1...3 {
                    
                    for symbol in 1...3 {
                        
                        let card = Card(number: Card.CardNumber(rawValue: number)!, symbol: Card.CardSymbol(rawValue: symbol)!, shading: Card.CardShading(rawValue: shading)!, color: Card.CardColor(rawValue: color)!, isSelected: false)
                        
                        cardsArray.append(card)
                        
                    }
                }
                
            }
            
        }
        
        shuffleCards()
        
    }
    
    func chechForMatch() -> Bool {
        
//        for i in cardsFacedUp.indices {
//            print("Number: \(cardsFacedUp[i].number), Symbol: \(cardsFacedUp[i].symbol), Shading: \(cardsFacedUp[i].shading), Color: \(cardsFacedUp[i].color)")
//        } //debugging statement
        
        if ((cardsFacedUp[0].number == cardsFacedUp[1].number && cardsFacedUp[1].number == cardsFacedUp[2].number)||(cardsFacedUp[0].number != cardsFacedUp[1].number && cardsFacedUp[1].number != cardsFacedUp[2].number)) && ((cardsFacedUp[0].symbol == cardsFacedUp[1].symbol && cardsFacedUp[1].symbol == cardsFacedUp[2].symbol)||(cardsFacedUp[0].symbol != cardsFacedUp[1].symbol && cardsFacedUp[1].symbol != cardsFacedUp[2].symbol)) && ((cardsFacedUp[0].shading == cardsFacedUp[1].shading && cardsFacedUp[1].shading == cardsFacedUp[2].shading)||(cardsFacedUp[0].shading != cardsFacedUp[1].shading && cardsFacedUp[1].shading != cardsFacedUp[2].shading)) && ((cardsFacedUp[0].color == cardsFacedUp[1].color && cardsFacedUp[1].color == cardsFacedUp[2].color)||(cardsFacedUp[0].color != cardsFacedUp[1].color && cardsFacedUp[1].color != cardsFacedUp[2].color)) {
            
            return true
            
        } else {
            
            return false
            
        }
            
        
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

