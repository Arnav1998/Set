//
//  ViewController.swift
//  Set
//
//  Created by ARNAV SINGHANIA on 6/18/18.
//  Copyright © 2018 Kay Bee Development. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController { 
    
    private var brain = SetBrain()
    private var indexTillCardsUsed = 11
    private var activeButtonCount = 12
    private var audioPlayer: AVAudioPlayer!
    private var audioPlayer2: AVAudioPlayer!
    private var soundStatus = true
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet var cardButtonsArray: [UIButton]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3")
        let url2 = Bundle.main.url(forResource: "buttonClickSound", withExtension: "mp3")
        
        if (soundStatus) {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url!)
                self.audioPlayer2 = try AVAudioPlayer(contentsOf: url2!)
                self.audioPlayer.play()
                self.audioPlayer.numberOfLoops = -1
                self.audioPlayer2.prepareToPlay()
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        brain.generateCards()
        
        for i in 0...23 {
            cardButtonsArray[i].layer.cornerRadius = 8.0
        }
        
        for i in 0...indexTillCardsUsed {
            cardButtonsArray[i].setAttributedTitle(getNSAtributedStringForCard(card: brain.cardsArray[i]), for: UIControl.State.normal)
            cardButtonsArray[i].accessibilityValue = String(i)
        }
        
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        
        if (self.soundStatus) {
            self.audioPlayer2.play()
        }
        
        if (sender.layer.borderWidth == 0.0) { //not selected
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            
            brain.cardsArray[Int(sender.accessibilityValue!)!].isSelected = true
            
        } else { //selected
            sender.layer.borderWidth = 0.0
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
            brain.cardsArray[Int(sender.accessibilityValue!)!].isSelected = false
    
        }
        
        if (brain.cardsFacedUp.count == 3) {
            
            if (brain.chechForMatch()) {
                
                brain.points += 5
                
                for i in 0..<activeButtonCount {
                    
                    if (cardButtonsArray[i].layer.borderWidth == 3.0) {
                        
                        brain.cardsArray[Int(cardButtonsArray[i].accessibilityValue!)!].isSelected = false
                        cardButtonsArray[i].layer.borderWidth = 0.0
                        cardButtonsArray[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                        indexTillCardsUsed += 1
                        cardButtonsArray[i].setAttributedTitle(getNSAtributedStringForCard(card: brain.cardsArray[indexTillCardsUsed]), for: UIControl.State.normal)
                        cardButtonsArray[i].accessibilityValue = String(indexTillCardsUsed)
                        
                    }
                    
                }
                
                
            } else {
                
                brain.points = brain.points - 2
                for i in 0..<activeButtonCount {
                    
                    if (cardButtonsArray[i].layer.borderWidth == 3.0) {
                        
                        brain.cardsArray[Int(cardButtonsArray[i].accessibilityValue!)!].isSelected = false
                        cardButtonsArray[i].layer.borderWidth = 0.0
                        cardButtonsArray[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                        
                    }
                    
                }
                
            }
            
            pointsLabel.text = "Points: \(brain.points)"
            
        }
        
    }
    
    @IBAction func addCardsButtonPressed(_ sender: UIButton) {
        
        if (activeButtonCount <= 21) {
            
            activeButtonCount += 3
            
            for i in 1...3 {
                
                cardButtonsArray[(activeButtonCount-4)+i].isEnabled = true
                cardButtonsArray[(activeButtonCount-4)+i].backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9333333333, alpha: 1)
                
                indexTillCardsUsed += 1
                cardButtonsArray[(activeButtonCount-4)+i].setAttributedTitle(getNSAtributedStringForCard(card:brain.cardsArray[indexTillCardsUsed]), for: UIControl.State.normal)
                
                cardButtonsArray[(activeButtonCount-4)+i].accessibilityValue = String(indexTillCardsUsed)
                
            }
            
        }
        
        if (activeButtonCount == 24) {
            sender.isEnabled = false
        }
    
    }
   
    @IBAction func newGameButtonPressed() {
        
        brain.points = 0
        
        indexTillCardsUsed = 11
        activeButtonCount = 12
        
        viewDidLoad()
        
        pointsLabel.text = "Points: \(brain.points)"

        for i in 12...cardButtonsArray.count-1 {
            
            cardButtonsArray[i].isEnabled = false
            cardButtonsArray[i].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            cardButtonsArray[i].setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            
        }
    
    }
    
    @IBAction func helpButtonPressed() {
        
        let alert = UIAlertController(title: "What Is A Set?", message: "A set consists of three cards satisfying all of these conditions.\n 1) They all have the same number or have three different numbers. \n 2) They all have the same symbol or have three different symbols. \n 3) They all have the same shading or have three different shadings. \n 4) They all have the same color or have three different colors. ", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Play", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        
        if (soundStatus) {
            soundStatus = false
            sender.setTitle("🔇", for: UIControl.State.normal)
            audioPlayer.stop()
        } else {
            soundStatus = true
            sender.setTitle("🔊", for: UIControl.State.normal)
            audioPlayer.play()
        }
        
    }
    
    private func getNSAtributedStringForCard(card: Card) -> NSAttributedString {
        
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



