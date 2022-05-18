//
//  ViewController.swift
//  Tipsy(No Storyboard)
//
//  Created by Eugene Kotovich on 15.04.2022.
//

import UIKit

class TipsyController: UIViewController {
    
    var tipsyBrain = TipsyBrain()
    
    var selectedTip: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Setup Buttons
    
    var buttons = [UIButton]()
    
    func createButtons() {
        for i in 0..<3 {
            let button = UIButton(type: .system)
            button.setTitle("\(i * 10)%", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
            button.tintColor = UIColor(named: "greenColor")
            button.backgroundColor = .clear
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 10
            button.tag = i
            button.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
            buttons.append(button)
        }
        
    }
    
    func updateTipButton() {
        for i in 0..<buttons.count {
            buttons[i].isSelected = i == selectedTip
        }
    }
    
    let calculateButton: UIButton = {
        $0.setTitle("Calculate", for: .normal)
        $0.setTitleColor(.white, for: .reserved)
        $0.titleLabel?.font = .systemFont(ofSize: 35.0)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "greenColor")
        $0.titleLabel?.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.addTarget(nil, action: #selector(calculatePressed), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        selectedTip = sender.tag
        updateTipButton()
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        splitNumbersLabel.text = "\(Int(sender.value))"
    }
    
    @objc func calculatePressed(_ sender: UIButton) {
        if let tip = selectedTip {
            tipsyBrain.calculate(text: billTextField.text ?? "0.0", split: Int(splitStepper.value), tip: tip)
            let controller = ResultViewController()
            controller.value = tipsyBrain.getResult()
            controller.tip = "\(tip * 10)"
            controller.split = "\(Int(splitStepper.value))"
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: - Setup Labels
    
    let textFieldLabel: UILabel = {
        $0.text = "Enter bill total"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let selectTipLabel: UILabel = {
        $0.text = "Select tip"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let splitLabel: UILabel = {
        $0.text = "Choose Split"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let splitNumbersLabel: UILabel = {
        $0.text = "2"
        $0.textColor = UIColor(named: "greenColor")
        $0.font = UIFont.systemFont(ofSize: 35)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    //MARK: - Setup TextField
    
    let billTextField: UITextField = {
        $0.textColor = UIColor(named: "greenColor")
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.textAlignment = .center
        $0.placeholder = "e.g. 123.56"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    //MARK: - Setup Stepper
    
    let splitStepper: UIStepper = {
        $0.value = 2
        $0.minimumValue = 2
        $0.maximumValue = 25
        $0.stepValue = 1
        $0.addTarget(nil, action: #selector(stepperValueChanged), for: .valueChanged)
        return $0
    }(UIStepper())
    
    //MARK: - Initialize UI
    
    func initialize() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        let topStack = UIStackView(arrangedSubviews: [textFieldLabel, billTextField])
        topStack.axis = .vertical
        topStack.alignment = .fill
        topStack.distribution = .fill
        topStack.spacing = 26
        view.addSubview(topStack)
        topStack.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        topStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        topStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        topStack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        
        textFieldLabel.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        billTextField.heightAnchor.constraint(equalToConstant: CGFloat(48)).isActive = true
        selectTipLabel.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor(named: "lightGreen")
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 40).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(calculateButton)
        calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        createButtons()
        let buttonsStack = UIStackView(arrangedSubviews: buttons)
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .fill
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 8
        
        
        let splitNumberStack = UIStackView(arrangedSubviews: [splitNumbersLabel, splitStepper])
        splitNumberStack.axis = .horizontal
        splitNumberStack.alignment = .fill
        splitNumberStack.distribution = .fillEqually
        
        let stack = UIStackView(arrangedSubviews: [selectTipLabel, buttonsStack, splitLabel, splitNumberStack])
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 26
        stack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        
    }
    
}

