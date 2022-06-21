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
    var wordsToMatch = ["SANKE"]
    var flag = true
    @IBOutlet weak var firstRowUIStackView: UIStackView!
    @IBOutlet var formLabels: [UILabel]!
    
    @IBOutlet weak var wordusUILabel: UILabel!
    @IBOutlet weak var inputTextHorizontalStackView: UIStackView!
    @IBOutlet weak var qwertyBoardStackView: UIStackView!
    @IBOutlet weak var submitWordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitWordButton.isEnabled = false
        for(_,label) in formLabels.enumerated(){
            label.textAlignment = .center
        }
        enableNextCell(index: 0)
    }
    
    @IBAction func qwertyPressed(_ sender: UIButton) {
        print("================================================================")
        print("FirstLine letterCounter: \(letterCounter)")
        if letterCounter % 5 != 0 || letterCounter == 0{
            if !flag {
                letterCounter = letterCounter - 1
                flag = true
            }
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
        }
    }
    @IBAction func onSubmitWord(_ sender: UIButton) {
        checkWord()
    }
    
    func checkWord() -> Bool{
        submitWordButton.isEnabled = false
        submitWordButton.backgroundColor = UIColor.lightGray
        var checkArr = [0,0,0,0,0]
     
        let word = wordsToMatch.randomElement()
        
        if word == guessedWord{
            
            //alert when right word is caught
            let alert = UIAlertController(title: "Great!", message: "You found the word.", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Restart Game", style: .default){ [self] _ in
                //removing all data on "Restart Game button pressed"
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
                guessCounter = 0
            }
            for (index,_) in checkArr.enumerated(){
                formLabels[index + (guessCounter * 5)].backgroundColor = UIColor.cyan
            }
            alert.addAction(okButton)
            self.show(alert, sender: nil)
            return true
        }
        else{
            for (indexI,i) in word!.enumerated(){
                for (indexJ,j) in guessedWord.enumerated(){
                    if i == j{
                        if indexI == indexJ{
                            checkArr[indexJ] = 1
                            print("with 1: \(i)")
                        }
                        else{
                            checkArr[indexJ] = 2
                            print("with 2: \(i)")
                        }
                    }
                }
            }
            for (index,ele) in checkArr.enumerated(){
                if ele == 1 {
                    formLabels[index + (guessCounter * 5)].backgroundColor = UIColor.cyan
                }
                if ele == 2{
                    formLabels[index + (guessCounter * 5)].backgroundColor = UIColor.orange
                }
            }
            letterCounter = letterCounter + 1
            print("After ++ \(letterCounter)" )
        }
        guessedWord = ""
        guessCounter = guessCounter + 1
        flag = false
        print("Only Print: \(letterCounter)")
        enableNextCell(index: letterCounter - 1)
        return false
    }
    func enableNextCell(index:Int){
        formLabels[index].layer.borderColor = UIColor.black.cgColor
        formLabels[index].layer.borderWidth = 3.0
    }
}

