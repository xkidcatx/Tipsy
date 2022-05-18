//
//  ResultViewController.swift
//  Tipsy(No Storyboard)
//
//  Created by Eugene Kotovich on 18.05.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var value = "0.0"
    var split = "2"
    var tip = "10"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Setup Labels
    
    let totalTitleLabel: UILabel = {
        $0.text = "Total per person"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let totalLabel: UILabel = {
        $0.text = "56.32"
        $0.textColor = UIColor(named: "greenColor")
        $0.font = UIFont.boldSystemFont(ofSize: 45)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let settingsLabel: UILabel = {
        $0.text = ""
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 25)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    //MARK: - Setup Buttons
    
    let recalculateButton: UIButton = {
        $0.setTitle("Recalculate", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 35.0)
        $0.titleLabel?.textAlignment = .center
        $0.backgroundColor = UIColor(named: "greenColor")
        $0.layer.cornerRadius = 10
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(nil, action: #selector(recalculatePressed), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Initialize UI
    
    func initialize() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        settingsLabel.text = "Split between \(split) people, with \(tip)% tip."
        totalLabel.text = value
        
        let topView = UIView()
        view.addSubview(topView)
        topView.backgroundColor = UIColor(named: "lightGreen")
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(totalTitleLabel)
        view.addSubview(totalLabel)
        view.addSubview(settingsLabel)
        
        view.addSubview(recalculateButton)
        recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recalculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [totalTitleLabel, totalLabel, settingsLabel])
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 26
        stack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
    }
    
    
}
