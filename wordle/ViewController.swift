//
//  ViewController.swift
//  wordle
//
//  Created by Sanket Patel on 2022-06-20.
//

import UIKit

class ViewController: UIViewController {
    
    var letterCounter = 0
    var guessCounter = 0
    var guessedWord = ""
    var wordsToMatch = ["Abuse", "Adult", "Agent", "Anger", "Award",  "Beach", "Birth", "Block", "Board", "Brain", "Bread", "Break", "Brown", "Buyer", "Cause", "Chain", "Chair", "Chest", "Chief", "Child", "China", "Claim", "Clock", "Coach", "Coast", "Court", "Cover", "Cream", "Crime", "Crowd", "Crown", "Dance", "Death", "Depth", "Doubt", "Draft", "Dream", "Drink", "Drive", "Earth",  "Entry", "Faith", "Fault", "Field", "Fight", "Final", "Focus", "Force", "Frame", "Frank", "Front", "Fruit", "Grant", "Group", "Guide", "Heart", "Henry", "Horse", "Hotel", "House", "Image", "Index", "Input", "Jones", "Judge", "Knife", "Laura", "Layer",  "Lewis", "Light", "Lunch", "Major", "March", "Match", "Metal", "Model", "Money", "Month", "Mouth", "Music", "Night", "Noise", "North", "Novel", "Nurse", "Other", "Owner", "Panel", "Paper", "Party", "Peace", "Phase", "Phone", "Pilot", "Pitch", "Place", "Plane", "Plant", "Plate", "Point", "Pound", "Power", "Price", "Pride", "Prize", "Radio", "Range", "Ratio", "Reply", "Right", "River", "Round", "Route", "Rugby", "Scale", "Scope", "Score", "Shape", "Share", "Shift", "Shirt", "Shock", "Sight", "Simon",  "Smile", "Smith", "Smoke", "Sound", "South", "Space", "Spite", "Sport", "Squad", "Stage", "Steam", "Stock", "Stone", "Store", "Study", "Style", "Sugar", "Table", "Taste", "Theme", "Thing",  "Touch", "Tower", "Track", "Trade", "Train", "Trend", "Trial", "Trust", "Truth", "Uncle", "Union", "Unity", "Value", "Video",  "Voice", "Waste", "Watch", "Water", "While", "White", "Whole", "Woman", "World", "Youth" ]
    var word = ""
    var flag = true
    @IBOutlet weak var firstRowUIStackView: UIStackView!
    @IBOutlet var formLabels: [UILabel]!
    @IBOutlet var keyBoardKeys: [UIButton]!
    @IBOutlet weak var wordusUILabel: UILabel!
    @IBOutlet weak var inputTextHorizontalStackView: UIStackView!
    @IBOutlet weak var qwertyBoardStackView: UIStackView!
    @IBOutlet weak var submitWordButton: UIButton!
    @IBOutlet weak var qButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitWordButton.isEnabled = false
        for(_,label) in formLabels.enumerated(){
            label.textAlignment = .center
        }
        enableNextCell(index: 0)
        clearKeyBoard()
        clearButton.tintColor = UIColor.red
        setNewWord()
    }
    
    @IBAction func qwertyPressed(_ sender: UIButton) {
        print("================================================================")
        print("FirstLine letterCounter: \(letterCounter) flag is:\(flag)")
        if letterCounter % 5 != 0 || letterCounter == 0{
            if !flag {
                letterCounter = letterCounter - 1
                flag = true
            }
            print("Letter counter Here!!\(letterCounter)")
            formLabels[letterCounter].text = sender.titleLabel?.text
            guessedWord.append(sender.titleLabel?.text ?? "")
            if flag {
                letterCounter = letterCounter + 1
            }
            flag = true
            print("================================================================")
            print("Second time letterCounter: \(letterCounter)")
            if letterCounter % 5 == 0 {
                submitWordButton.backgroundColor = UIColor.blue
                submitWordButton.isEnabled = true
            }
            else{
                submitWordButton.backgroundColor = UIColor.lightGray
                submitWordButton.isEnabled = false
                enableNextCell(index: letterCounter)
            }
            wordusUILabel.text = guessedWord
        }
    }
    @IBAction func onCleareButtonPressed(_ sender: UIButton) {
        if guessedWord.count  > 0{
            formLabels[letterCounter].layer.borderWidth = 0.0
            letterCounter = letterCounter - 1
            guessedWord.removeLast()
            wordusUILabel.text = guessedWord
            formLabels[letterCounter].text = ""
            if letterCounter % 5 == 0{
                flag = false
                letterCounter = letterCounter + 1
            }
        }
    }
    @IBAction func onSubmitWord(_ sender: UIButton) {
        checkWord()
    }
    
    func checkWord() -> Bool{
        submitWordButton.isEnabled = false
        submitWordButton.backgroundColor = UIColor.lightGray
     
        
        print(word)
        if word == guessedWord{
            
            //alert when right word is caught
            let alert = UIAlertController(title: "Great!", message: "You found the word.", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Restart Game", style: .default){ [self] _ in
                //removing all data on "Restart Game button pressed"
               clearBoard()
                clearKeyBoard()
                setNewWord()
            }
            for index in 0...4{
                formLabels[index + (guessCounter * 5)].backgroundColor = UIColor.cyan
            }
            alert.addAction(okButton)
            self.show(alert, sender: nil)
            return true
        }
        else{
            for (indexI,i) in word.enumerated(){
                for (indexJ,j) in guessedWord.enumerated(){
                    if i == j{
                        if indexI == indexJ{
                            changeKeyBoardKeyAndFormCellColor(indexJ: indexJ, color: UIColor.cyan, letter: String(i))
                        }
                        else{
                            changeKeyBoardKeyAndFormCellColor(indexJ: indexJ, color: UIColor.orange, letter: String(i))
                        }
                    }
                }
            }
            letterCounter = letterCounter + 1
        }
        guessedWord = ""
        guessCounter = guessCounter + 1
        flag = false
        if guessCounter == 6 {
            let alert = UIAlertController(title: "Ohh NO!", message: "you are looser! The Word is \(word)", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Restart Game", style: .default){ [self] _ in
                clearBoard()
                clearKeyBoard()
            }
            alert.addAction(okButton)
            self.show(alert, sender: nil)
            setNewWord()
            guessCounter = 0
            flag = true
//            letterCounter = 0
        }
        print("letter counter before enabling nextCell:========\(letterCounter)")
        enableNextCell(index: letterCounter - 1)
        return false
    }
    func enableNextCell(index:Int){
        if index < 30{
            formLabels[index].layer.borderColor = UIColor.black.cgColor
            formLabels[index].layer.borderWidth = 3.0
        }
    }
    func changeKeyBoardKeyAndFormCellColor(indexJ:Int, color:UIColor, letter:String){
        for selectedKey in keyBoardKeys{
            let keyTitle = selectedKey.titleLabel?.text!
            print(keyTitle!)
            if keyTitle! == letter{
                if selectedKey.tintColor != UIColor.cyan{
                    selectedKey.tintColor = color
                }
                break
            }
        }
        formLabels[indexJ + (guessCounter * 5)].backgroundColor = color
    }
    func clearBoard(){
        if letterCounter > 29 {
            letterCounter = 29
            formLabels[letterCounter].text = ""
        }
        while(self.letterCounter > 0){
            formLabels[letterCounter].layer.borderWidth = 0.0
            formLabels[letterCounter].backgroundColor = UIColor.lightGray
            letterCounter = letterCounter - 1
            if guessedWord.count > 0{
                guessedWord.removeLast()
            }
            //remove below line at last
            wordusUILabel.text = guessedWord
            formLabels[letterCounter].text = ""
        }
//                formLabels[letterCounter].layer.borderWidth = 0.0
        formLabels[letterCounter].backgroundColor = UIColor.lightGray
        guessCounter = 0
        letterCounter = 0
    }
    func clearKeyBoard(){
        for (_,key) in keyBoardKeys.enumerated(){
            key.tintColor = UIColor.darkGray
        }
    }
    func setNewWord(){
        word = wordsToMatch.randomElement()!.uppercased()
        print(word)
    }
}

