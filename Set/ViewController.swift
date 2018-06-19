//
//  ViewController.swift
//  Set
//
//  Created by ARNAV SINGHANIA on 6/18/18.
//  Copyright © 2018 Kay Bee Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain = SetBrain()
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet var cardButtonsArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load 12 cards at random
        brain.generateCards()
        
        for i in 0...11 {
            
           let randomNum = Int(arc4random_uniform(UInt32(brain.cardsArray.count-1)))
           cardButtonsArray[i].setAttributedTitle(getNSAtributedStringForCard(card: brain.cardsArray[randomNum]), for: UIControl.State.normal)
           brain.cardsArray.remove(at: randomNum)
            
        }
        
    }
    
    @IBAction func addCardsButtonPressed() {
    }

    @IBAction func newGameButtonPressed() {
    }
    
    @IBAction func helpButtonPressed() {
    }
    
    @IBAction func soundButtonPressed(_ sender: UIButton) {
    }
    
    private func getNSAtributedStringForCard(card: Card) -> NSAttributedString { //logic error
        
        var attributes = [NSAttributedString.Key:Any]()
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 20)
        
        if (card.color.rawValue == 1) {
            
            attributes[NSAttributedString.Key.strokeColor] = UIColor.red
            
            if (card.shading.rawValue == 1) { //solid
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.red.withAlphaComponent(1)
                attributes[NSAttributedString.Key.strokeWidth] = -5.0
            } else if (card.shading.rawValue == 2) { //open
                attributes[NSAttributedString.Key.strokeWidth] = 5.0
            } else if (card.shading.rawValue == 3) { //striped
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.red.withAlphaComponent(0.15)
            }
            
        } else if (card.color.rawValue == 2) {
            
            attributes[NSAttributedString.Key.strokeColor] = UIColor.magenta
            
            if (card.shading.rawValue == 1) { //solid
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.magenta.withAlphaComponent(1)
                attributes[NSAttributedString.Key.strokeWidth] = -5.0
            } else if (card.shading.rawValue == 2) { //open
                attributes[NSAttributedString.Key.strokeWidth] = 5.0
            } else if (card.shading.rawValue == 3) { //striped
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.magenta.withAlphaComponent(0.15)
            }
            
        } else if (card.color.rawValue == 3) {
            
            attributes[NSAttributedString.Key.strokeColor] = UIColor.black
            
            if (card.shading.rawValue == 1) { //solid
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.black.withAlphaComponent(1)
                attributes[NSAttributedString.Key.strokeWidth] = -5.0
            } else if (card.shading.rawValue == 2) { //open
                attributes[NSAttributedString.Key.strokeWidth] = 5.0
            } else if (card.shading.rawValue == 3) { //striped
                attributes[NSAttributedString.Key.foregroundColor] = UIColor.black.withAlphaComponent(0.15)
            }
        }
        
        var string: String
        
        if (card.symbol.rawValue == 1) {
            string = "▲"
        } else if (card.symbol.rawValue == 2) {
            string = "●"
        } else if (card.symbol.rawValue == 3) {
            string = "■"
        } else {
            string = "?"
        }
     
        if (card.number.rawValue == 2) {
            string.append(string)
        } else if (card.number.rawValue == 3) {
            string.append(string)
            string.append(string[string.startIndex])
        }
        
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
        return attributedString
        
    }
    
}

