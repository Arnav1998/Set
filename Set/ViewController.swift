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
    private var activeButtonsCount = 12
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet var cardButtonsArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        brain.generateCards()
        
        for i in 0...23 {
            cardButtonsArray[i].layer.cornerRadius = 8.0
        }
        
        for i in 0...11 {
            
            cardButtonsArray[i].setAttributedTitle(getNSAtributedStringForCard(card: brain.cardsArray[i]), for: UIControl.State.normal)
            
        }
        
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        
        if (sender.layer.borderWidth == 0.0) {
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
            
            brain.cardsArray[cardButtonsArray.index(of: sender)!].isSelected = true
            
        } else {
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            sender.layer.borderWidth = 0.0
            
            brain.cardsArray[cardButtonsArray.index(of: sender)!].isSelected = false
            
        }
        
        if (brain.cardsFacedUp.count == 3) {
            print(brain.chechForMatch())

        }
        
    }
    
    @IBAction func addCardsButtonPressed() {
        
        activeButtonsCount += 3
        
        for i in 1...3 {
            
            cardButtonsArray[(activeButtonsCount-4)+i].isEnabled = true
            cardButtonsArray[(activeButtonsCount-4)+i].backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9333333333, alpha: 1)
        cardButtonsArray[(activeButtonsCount-4)+i].setAttributedTitle(getNSAtributedStringForCard(card:brain.cardsArray[(activeButtonsCount-4)+i]), for: UIControl.State.normal)

        }
        
    }

    @IBAction func newGameButtonPressed() {
    }
    
    @IBAction func helpButtonPressed() {
    }
    
    @IBAction func soundButtonPressed(_ sender: UIButton) {}
    
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

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

extension UIButton {
    override open var isSelected: Bool {
        get {
            return self.layer.borderWidth == 3.0
        } set {
            self.isSelected = newValue
        }
    }
}


