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
    var wrongGuessLabel: UILabel!
    var scoreLabel: UILabel!
    var selectedLetter: UILabel!
    var wordToGuessLabel: UILabel!
    var lettersButtons = [UIButton]()
    var nextButton: UIButton!
    
    var currentWord = [String]()
    var usedWords = [String]()
    var index = 0
    var wordToGuess = "femme"
    
    var wrongGuess = 0 {
        didSet {
            wrongGuessLabel.text = "Wrong Guess: \(wrongGuess)/7"
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
        
        wrongGuessLabel = UILabel()
        wrongGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongGuessLabel.text = "Wrong Guess 0/7"
        wrongGuessLabel.font = UIFont.systemFont(ofSize: 20)
        wrongGuessLabel.textColor = .white
        view.addSubview(wrongGuessLabel)
        
        nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .white
        nextButton.titleLabel?.textAlignment = .center
        nextButton.isHidden = false
        view.addSubview(nextButton)
        
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
        selectedLetter.isHidden = true
        //        selectedLetter.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(selectedLetter)
        
        wordToGuessLabel = UILabel()
        wordToGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        wordToGuessLabel.font = UIFont.systemFont(ofSize: 44)
        wordToGuessLabel.text = "?????"
        wordToGuessLabel.textColor = .white
        wordToGuessLabel.textAlignment = .center
        //        wordToGuess.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(wordToGuessLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            wrongGuessLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            wrongGuessLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            selectedLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedLetter.bottomAnchor.constraint(equalTo: wordToGuessLabel.topAnchor, constant: -50),
            selectedLetter.heightAnchor.constraint(equalToConstant: 44),
            selectedLetter.widthAnchor.constraint(equalToConstant: 44),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: wordToGuessLabel.topAnchor, constant: -50),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 80),
            //            wordToGuess.topAnchor.constraint(equalTo: selectedLetter.bottomAnchor, constant: 20),
            wordToGuessLabel.heightAnchor.constraint(equalToConstant: 40),
            wordToGuessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 88),
            buttonsView.widthAnchor.constraint(equalToConstant: 572),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: wordToGuessLabel.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ])
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        
        let width = 44
        let height = 44
        
        for row in 0..<2 {
            for col in 0..<13 {
                
                let letterButton = UIButton(type: .system)
                letterButton.setTitleColor(.black, for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
        //        performSelector(inBackground: #selector(loadWords), with: nil)
    }
    
    fileprivate func endGameAlert(title: String, message: String) {
        let ac = UIAlertController(title: title , message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: newGame))
        present(ac, animated: true)
    }
    
    func loadWords() {
        
        if let wordsFileUrl = Bundle.main.url(forResource: "Mots", withExtension: "txt") {
            if let wordsFileContent = try? String(contentsOf: wordsFileUrl) {
                var word = wordsFileContent.components(separatedBy: "\n")
                word.removeLast()
                word.shuffle()
                
                wordToGuess = word[index]
                usedWordsMethod()
                currentWord = word
                print(wordToGuess)
                wrongGuess = 0
                wordToGuessLabel.text = String.init(repeating: "?", count: wordToGuess.count)
                nextButton.isHidden = true
                
                for button in lettersButtons {
                    button.isHidden = false
                }
            }
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }
        nextButton.isHidden = true
        selectedLetter.isHidden = false
        selectedLetter.text = letter
        
        if wordToGuess.contains(letter) {
            var bits = wordToGuessLabel.text?.map {$0.uppercased()}
            for (index, item) in wordToGuess.enumerated() {
                if String(item) == letter {
                    bits![index] = letter
                }
            }
            wordToGuessLabel.text = bits?.joined()
            sender.isHidden = true
            
            if wordToGuessLabel.text == wordToGuess {
                selectedLetter.isHidden = true
                nextButton.isHidden = false
                usedWords.append(wordToGuess)
                score += 1
                if score == currentWord.count {
                    endGameAlert(title: "Waouh", message: "You won!")
                }
                
            }
            
            
        } else {
            sender.isHidden = true
            wrongGuess += 1
            if wrongGuess == 7 {
                endGameAlert(title: "You loose!", message: "the word was \(wordToGuess)")
            }
        }
    }
    
    fileprivate func usedWordsMethod() {
        if usedWords.contains(wordToGuess) {
            loadWords()
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        nextButton.isHidden = false
        loadWords()
//        usedWordsMethod()
    }
    
    @objc func newGame(action: UIAlertAction) {
        nextButton.isHidden = true
        selectedLetter.isHidden = true
        score = 0
        wrongGuess = 0
        index = 0
        usedWords.removeAll(keepingCapacity: true)
        loadWords()
    }
}

