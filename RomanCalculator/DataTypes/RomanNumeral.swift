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
    
    func toInt() -> Int {
        var result = 0
        var index = 0
        
        while index < numerals.count {
            let symbolValue = numerals[index].toInt()
            guard index + 1 < numerals.count else {
                result += symbolValue
                break
            }
            
            let nextSymbolValue = numerals[index + 1].toInt()
            
            if nextSymbolValue > symbolValue {
                result += nextSymbolValue - symbolValue
                index += 1
            }
            else {
                result += symbolValue
            }
            index += 1
        }
        
        return result
    }
}

extension RomanNumeral: Comparable {
    static func < (lhs: RomanNumeral, rhs: RomanNumeral) -> Bool {
        return lhs.toInt() < rhs.toInt()
    }
}
