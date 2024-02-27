//
//  RomanNumeral.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 25.02.24.
//

struct RomanNumeral {
    var numerals: [RomanNumeralSymbol] = []
    
    init() {}
    
    init(numerals: [RomanNumeralSymbol]) {
        self.numerals = numerals
    }
    
    func toString() -> String {
        var string = ""
        
        for numeral in numerals {
            string += numeral.toString()
        }
        
        return string
    }
}
