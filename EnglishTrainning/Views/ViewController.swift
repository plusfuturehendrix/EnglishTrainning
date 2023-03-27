//
//  ViewController.swift
//  EnglishTrainning
//
//  Created by Danil Bochkarev on 27.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - Settings properties
    let wordLabel: UILabel = {
        let word = UILabel()
        word.font = UIFont.systemFont(ofSize: 36)
        word.textColor = .black
        return word
    }()
    
    let optionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    let buttonNext: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Private properties & Settings properties
    private let words = English.words
    private let translations = Russia.translations
    private let optionButtons = [UIButton(), UIButton(), UIButton()]
    private var currentWordIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
    }
    
    //MARK: - Methods
    @objc func optionSelected(_ sender: UIButton) {
        if sender.currentTitle == translations[currentWordIndex] {
            resultLabel.text = "Correct! Go next!"
        } else {
            resultLabel.text = "Incorrect! Correctly translate \(translations[currentWordIndex])"
        }
    }
    
    @objc func nextMethod() {
        currentWordIndex += 1
        if currentWordIndex >= words.count {
            currentWordIndex = 0
        }
        setWord(word: words[currentWordIndex], options: getRandomOptions())
        resultLabel.text = ""
    }
    
    func setWord(word: String, options: [String]) {
        wordLabel.text = word
        for (index, optionButton) in optionButtons.enumerated() {
            optionButton.setTitle(options[index], for: .normal)
        }
    }
    
    func getRandomOptions() -> [String] {
        var options = translations
        options.remove(at: currentWordIndex)
        options.shuffle()
        options = Array(options.prefix(2))
        options.append(translations[currentWordIndex])
        options.shuffle()
        return options
    }
}

//MARK: - Setting Constraint
private extension ViewController {
    func initialize() {
        view.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }

        view.addSubview(optionsStackView)
        optionsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(wordLabel.snp.bottom).offset(50)
        }
        
        for optionButton in optionButtons {
            optionButton.backgroundColor = .systemGray
            optionButton.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(optionButton)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(optionsStackView).inset(-50)
        }
        
        view.addSubview(buttonNext)
        buttonNext.addTarget(self, action: #selector(nextMethod), for: .touchUpInside)
        buttonNext.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(resultLabel).inset(-50)
        }
        
        // set up initial word and options
        setWord(word: words[currentWordIndex], options: getRandomOptions())
    }
}
