//
//  InputParser.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 27.02.24.
//

import Foundation

typealias RomanMathematicalExpression = (lhs: RomanNumeral,
                                         expression: MathematicalExpression,
                                         rhs: RomanNumeral)

class InputParser {
    static private let mathematicalExpressionParts = 3
    static private let lhsIndex = 0
    static private let rhsIndex = 2
    static private let expressionIndex = 1
    
    static func parseMathematicalExpression(from input: String) -> RomanMathematicalExpression? {
        let inputStrings = input.components(separatedBy: " ")
        guard inputStrings.count >= mathematicalExpressionParts else {
            return nil
        }

        let lhs = RomanNumeralParser.parseRomanNumerals(from: inputStrings[lhsIndex])
        let rhs = RomanNumeralParser.parseRomanNumerals(from: inputStrings[rhsIndex])
        
        guard let expression = MathematicalExpression(rawValue: inputStrings[expressionIndex]),
              !lhs.numerals.isEmpty,
              !rhs.numerals.isEmpty else {
            return nil
        }
        
        return (lhs, expression, rhs)
    }
}
