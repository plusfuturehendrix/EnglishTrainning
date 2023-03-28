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
        word.textColor = .black
        word.font = UIFont(name: "MontserratAlternates-Black", size: 50)
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
        button.backgroundColor = #colorLiteral(red: 0.1183932796, green: 0.130817771, blue: 0.1623123288, alpha: 1)
        button.layer.cornerRadius = 12
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: "MontserratAlternates-SemiBold", size: 24)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var resultImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "emoij")
        return image
    }()
    
    //MARK: - Private properties & Settings properties
    private let words = English.words
    private let translations = Russia.translations
    private let optionButtons = [UIButton(), UIButton(), UIButton()]
    private var currentWordIndex = 0
    private var checkStatusResult = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
    }
    
    //MARK: - Methods
    @objc func optionSelected(_ sender: UIButton) {
        if sender.currentTitle == translations[currentWordIndex] {
            resultImage.image = UIImage(systemName: "checkmark.circle")
            resultImage.tintColor = .green
            checkStatusResult = true
        } else {
            resultImage.tintColor = .red
            resultImage.image = UIImage(systemName: "xmark.circle")
            checkStatusResult = false
        }
    }
    
    @objc func nextMethod() {
        if checkStatusResult {
            currentWordIndex += 1
            if currentWordIndex >= words.count {
                currentWordIndex = 0
            }
            setWord(word: words[currentWordIndex], options: getRandomOptions())
            resultImage.image = nil
            checkStatusResult = false
            resultImage.image = UIImage(named: "emoij")
        }
    }
    
    func setWord(word: String, options: [String]) {
        wordLabel.text = word
        for (index, optionButton) in optionButtons.enumerated() {
            optionButton.setTitle(options[index], for: .normal)
            optionButton.setTitleColor(#colorLiteral(red: 0.1183932796, green: 0.130817771, blue: 0.1623123288, alpha: 1), for: .normal)
            optionButton.backgroundColor = .clear
            optionButton.layer.cornerRadius = 12
            optionButton.layer.borderWidth = 2
            optionButton.layer.borderColor = #colorLiteral(red: 0.1183932796, green: 0.130817771, blue: 0.1623123288, alpha: 1)
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
        view.addSubview(resultImage)
        resultImage.snp.makeConstraints { make in
            make.width.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height / 7)
        }
        
        view.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultImage.snp.top).offset(UIScreen.main.bounds.height / 7)
        }

        view.addSubview(optionsStackView)
        optionsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(wordLabel.snp.bottom).offset(50)
        }
        
        for optionButton in optionButtons {
            optionButton.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(optionButton)
            optionButton.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width - 100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
            }
        }
        
        view.addSubview(buttonNext)
        buttonNext.addTarget(self, action: #selector(nextMethod), for: .touchUpInside)
        buttonNext.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 100)
            make.height.equalTo(50)
            make.bottom.equalTo(optionsStackView).inset(-100)
        }
        
        // set up initial word and options
        setWord(word: words[currentWordIndex], options: getRandomOptions())
    }
}
