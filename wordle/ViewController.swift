//
//  ViewController.swift
//  wordle
//
//  Created by Sanket Patel on 2022-06-20.
//

import UIKit

class ViewController: UIViewController {

    var guessCounter = 0
    var letterCounter = 0
    var guessedWord = ""
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
        formLabels[0].layer.borderColor = UIColor.black.cgColor
        formLabels[0].layer.borderWidth = 3.0
    }


    @IBAction func onKeyboardButtonPressed(_ sender: UIButton) {
        
    }
    @IBAction func qwertyPressed(_ sender: UIButton) {
        formLabels[guessCounter].text = sender.titleLabel?.text
        guessedWord.append(sender.titleLabel?.text ?? "")
        guessCounter = guessCounter + 1
        if guessCounter % 5 == 0{
            submitWordButton.backgroundColor = UIColor.blue
            submitWordButton.isEnabled = true
        }else{
            submitWordButton.backgroundColor = UIColor.lightGray
            submitWordButton.isEnabled = false
        }
        formLabels[guessCounter].layer.borderColor = UIColor.black.cgColor
        formLabels[guessCounter].layer.borderWidth = 3.0
        wordusUILabel.text = guessedWord
    }
}

