//
//  ViewController.swift
//  Concentration
//
//  Created by Ori Mizrahi on 3/21/20.
//  Copyright © 2020 bigo technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    lazy var emojiChoices1: [String] = chooseEmojiChoices()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        Card.identifierFactory = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices1 = chooseEmojiChoices()
        emoji.removeAll()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    
    var sportsEmojis: Array<String> = ["⚽️","🏀","🏈","🥎","🏓","🥋","🥏","⛳️"]
    
    var animalEmojis: Array<String> = ["🐶","🐱","🐸","🙉","🐥","🐧","🐹","🐼"]
    
    var foodEmojis: Array<String> = ["🍗","🌮","🍣","🍜","🧁","🍕","🍟","🍔"]
    
    var faceEmojis: Array<String> = ["😀","🤢","🤩","🤬","🥶","😘","🥳","😴"]
    
    var workEmojis: Array<String> = ["✉️","📆","🗑","📈","📕","📚","📌","✏️"]
    
    var vehicleEmojis: Array<String> = ["🚗","🚟","🚑","⛵️","🚁","✈️","🚀","🛵"]
    
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices1.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices1.count)))
            emoji[card.identifier] = emojiChoices1.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func chooseEmojiChoices() -> [String]{
        switch game.emojiInt {
        case 1:
            return sportsEmojis
        
        case 2:
            return animalEmojis
        
        case 3:
            return foodEmojis
        
        case 4:
            return faceEmojis
        
        case 5:
            return workEmojis
        
        case 6:
            return vehicleEmojis
        
         default:
            return sportsEmojis
        }
    }
}
