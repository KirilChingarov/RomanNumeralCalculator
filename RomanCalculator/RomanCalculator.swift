//
//  RomanCalculator.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 26.02.24.
//

import Foundation

class RomanCalculator {
    var lhs: RomanNumeral
    var rhs: RomanNumeral
    
    init() {
        lhs = RomanNumeral()
        rhs = RomanNumeral()
    }
    
    private func removeCommonNumerals() {
        var index = 0
        
        while index < rhs.numerals.count {
            let targetNumeral = rhs.numerals[index]
            
            guard lhs.numerals.contains(targetNumeral),
                  let targetIndex = lhs.numerals.firstIndex(of: targetNumeral) else {
                index += 1
                continue
            }
            
            rhs.numerals.remove(at: index)
            lhs.numerals.remove(at: targetIndex)
        }
    }
    
    func executeExpression(expression: RomanMathematicalExpression) -> RomanNumeral {
        switch expression.expression {
        case .addition:
            return romanAddition(lhs: expression.lhs, rhs: expression.rhs)
        case .subtraction:
            return romanSubtraction(lhs: expression.lhs, rhs: expression.rhs)
        }
    }
    
    func romanAddition(lhs leftNumeral: RomanNumeral, rhs rightNumeral: RomanNumeral) -> RomanNumeral {
        lhs = RomanNumeralConverter.convertSubtractiveNotationToAdditive(leftNumeral)
        rhs = RomanNumeralConverter.convertSubtractiveNotationToAdditive(rightNumeral)
        var result = RomanNumeral()
        
        result.numerals.append(contentsOf: lhs.numerals)
        result.numerals.append(contentsOf: rhs.numerals)
        
        result.numerals.sort(by: >)
        
        result = RomanNumeralConverter.simplify(result)
        
        return RomanNumeralConverter.convertAdditiveNotationToSubtractive(result)
    }
    
    func romanSubtraction(lhs leftNumeral: RomanNumeral, rhs rightNumeral: RomanNumeral) -> RomanNumeral {
        lhs = RomanNumeralConverter.convertSubtractiveNotationToAdditive(leftNumeral)
        rhs = RomanNumeralConverter.convertSubtractiveNotationToAdditive(rightNumeral)
        
        repeat {
            removeCommonNumerals()
            if rhs.numerals.isEmpty {
                break
            }
            
            lhs.numerals += RomanNumeralConverter.expandRomanNumeralSymbol(lhs.numerals.removeLast())
        }while !rhs.numerals.isEmpty
        
        let result = RomanNumeralConverter.simplify(lhs)
        
        return RomanNumeralConverter.convertAdditiveNotationToSubtractive(result)
    }
}
