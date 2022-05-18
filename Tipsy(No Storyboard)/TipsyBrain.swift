//
//  TipsyBrain.swift
//  Tipsy(No Storyboard)
//
//  Created by Eugene Kotovich on 18.05.2022.
//

import Foundation

struct TipsyBrain {
    
    var value = 0.0
    var split = 2
    var tip = 0
    var result: Double {
        (value * Double(tip) / 10) / Double(split)
    }
    
    mutating func calculate(text: String, split: Int, tip: Int) {
        self.value = Double(text) ?? 0.0
        self.split = split
        self.tip = tip
    }
    
    func getResult() -> String {
        String(format: "%.2f", result)
    }
}
