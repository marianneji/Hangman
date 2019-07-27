//
//  ViewController.swift
//  Hangman
//
//  Created by Graphic Influence on 26/07/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel!
    var guessLabel: UILabel!
    var scoreLabel: UILabel!
    var selectedLetter: UILabel!
    var wordToGuess: UILabel!
    var lettersButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solution = [String]()
    var index = 0
    
    var guess = 0 {
        didSet {
            guessLabel.text = "Guess: \(guess)/7"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
   
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "HANGMAN"
        titleLabel.font = UIFont.systemFont(ofSize: 44)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .red
        view.addSubview(titleLabel)
        
        guessLabel = UILabel()
        guessLabel.translatesAutoresizingMaskIntoConstraints = false
        guessLabel.text = "Guess 0/7"
        guessLabel.font = UIFont.systemFont(ofSize: 20)
        guessLabel.textColor = .white
        view.addSubview(guessLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        selectedLetter = UILabel()
        selectedLetter.translatesAutoresizingMaskIntoConstraints = false
        selectedLetter.text = "A"
        selectedLetter.textAlignment = .center
        selectedLetter.font = UIFont.systemFont(ofSize: 30)
        selectedLetter.backgroundColor = .white
        selectedLetter.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(selectedLetter)
        
        wordToGuess = UILabel()
        wordToGuess.translatesAutoresizingMaskIntoConstraints = false
        wordToGuess.font = UIFont.systemFont(ofSize: 44)
        wordToGuess.text = "?????"
        wordToGuess.textColor = .white
        wordToGuess.textAlignment = .center
        wordToGuess.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(wordToGuess)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            guessLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            guessLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            selectedLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedLetter.bottomAnchor.constraint(equalTo: wordToGuess.topAnchor, constant: -50),
            selectedLetter.heightAnchor.constraint(equalToConstant: 44),
            selectedLetter.widthAnchor.constraint(equalToConstant: 44),
//            wordToGuess.topAnchor.constraint(equalTo: selectedLetter.bottomAnchor, constant: 20),
            wordToGuess.heightAnchor.constraint(equalToConstant: 40),
            wordToGuess.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 88),
            buttonsView.widthAnchor.constraint(equalToConstant: 572),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: wordToGuess.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -200)
            ])
        
        let width = 44
        let height = 44
        
        for row in 0..<2 {
            for col in 0..<13 {
                
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                    letterButton.backgroundColor = .white
                    letterButton.layer.borderWidth = 1
                    letterButton.layer.borderColor = UIColor.gray.cgColor
                    letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                    
                    let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                    letterButton.frame = frame
                    
                    
                    buttonsView.addSubview(letterButton)
                    lettersButtons.append(letterButton)
            }
        }
        
        for (index, letter) in "abcdefghijklmnopqrstuvwxyz".uppercased().enumerated() {
            lettersButtons[index].setTitle(String(letter), for: .normal)
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

