//
//  RomanNumeralConverter.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 26.02.24.
//

import Foundation

class RomanNumeralConverter {
    
    private static func convertSubtractiveNotationToAdditive(_ subtractiveNumeral: RomanNumeralSymbol, _ baseNumber: RomanNumeralSymbol) -> [RomanNumeralSymbol] {
        switch (subtractiveNumeral, baseNumber) {
        case (.I, .V):
            return [.I, .I, .I, .I]
        case (.I, .X):
            return [.V, .I, .I, .I, .I]
        case (.X, .L):
            return [.X, .X, .X, .X]
        case (.X, .C):
            return [.L, .X, .X, .X, .X]
        case (.C, .D):
            return [.C, .C, .C, .C]
        case (.C, .M):
            return [.D, .C, .C, .C, .C]
        default:
            return [subtractiveNumeral, baseNumber]
        }
    }
    
    private static func convertAdditiveNotationToSubtractive(repeatingSymbol: RomanNumeralSymbol, previousSymbol: RomanNumeralSymbol? = nil) -> [RomanNumeralSymbol] {
        guard let previousSymbol else {
            switch repeatingSymbol {
            case .I:
                return [.I, .V]
            case .X:
                return [.X, .L]
            case .C:
                return [.C, .D]
            default:
                return Array(repeating: repeatingSymbol, count: 4)
            }
        }
        
        switch (previousSymbol, repeatingSymbol) {
        case ( .V, .I ):
            return [.I, .X]
        case ( _ , .I ):
            return [previousSymbol, .I, .V]
        case ( .L, .X ):
            return [.X, .C]
        case ( _ , .X ):
            return [previousSymbol, .X, .L]
        case ( .D, .C ):
            return [.C, .M]
        case ( _ , .C ):
            return [previousSymbol, .C, .D]
        default:
            return [previousSymbol] + Array(repeating: repeatingSymbol, count: 4)
        }
    }
    
    private static func simplifyConsecutiveRomanSymbols(romanNumeral: RomanNumeralSymbol, count: Int) -> [RomanNumeralSymbol] {
        switch romanNumeral {
        case .I:
            let vNumerals = Array(repeating: RomanNumeralSymbol.V, count: count / 5)
            let iNumerals = Array(repeating: RomanNumeralSymbol.I, count: count % 5)
            return vNumerals + iNumerals
        case .V:
            let xNumerals = Array(repeating: RomanNumeralSymbol.X, count: count / 2)
            let vNumerals = Array(repeating: RomanNumeralSymbol.V, count: count % 2)
            return xNumerals + vNumerals
        case .X:
            let lNumerals = Array(repeating: RomanNumeralSymbol.L, count: count / 5)
            let xNumerals = Array(repeating: RomanNumeralSymbol.X, count: count % 5)
            return lNumerals + xNumerals
        case .L:
            let cNumerals = Array(repeating: RomanNumeralSymbol.C, count: count / 2)
            let lNumerals = Array(repeating: RomanNumeralSymbol.L, count: count % 2)
            return cNumerals + lNumerals
        case .C:
            let dNumerals = Array(repeating: RomanNumeralSymbol.D, count: count / 5)
            let cNumerals = Array(repeating: RomanNumeralSymbol.C, count: count % 5)
            return dNumerals + cNumerals
        case .D:
            let mNumerals = Array(repeating: RomanNumeralSymbol.M, count: count / 2)
            let dNumerals = Array(repeating: RomanNumeralSymbol.D, count: count % 2)
            return mNumerals + dNumerals
        case .M:
            return Array(repeating: RomanNumeralSymbol.M, count: count)
        }
    }
    
    private static func countConsecutiveRomanNumerals(_ number: RomanNumeral, startingIndex: Int = 0) -> Int {
        var endingIndex = startingIndex + 1
        
        while endingIndex < number.numerals.count && number.numerals[endingIndex] == number.numerals[startingIndex]{
            endingIndex += 1
        }
        
        return endingIndex - startingIndex
    }
    
    static func expandRomanNumeralSymbol(_ romanNumeral: RomanNumeralSymbol?) -> [RomanNumeralSymbol] {
        guard let romanNumeral else{
            return []
        }
        
        switch romanNumeral {
        case .I:
            return [.I]
        case .V:
            return [.I, .I, .I, .I, .I]
        case .X:
            return [.V, .V]
        case .L:
            return [.X, .X, .X, .X, .X]
        case .C:
            return [.L, .L]
        case .D:
            return [.C, .C, .C, .C, .C]
        case .M:
            return [.D, .D]
        }
    }
    
    static func convertSubtractiveNotationToAdditive(_ number: RomanNumeral) -> RomanNumeral {
        var converted = RomanNumeral()
        var index = 0
        
        while index < number.numerals.count {
            if index + 1 < number.numerals.count
                && number.numerals[index] < number.numerals[index + 1] {
                let numerals = convertSubtractiveNotationToAdditive(number.numerals[index], number.numerals[index + 1])
                converted.numerals.append(contentsOf: numerals)
                index += 1
            }
            else {
                converted.numerals.append(number.numerals[index])
            }
            
            index += 1
        }
        
        return converted
    }
    
    static func convertAdditiveNotationToSubtractive(_ number: RomanNumeral) -> RomanNumeral {
        var converted = number
        
        for romanNumeral in RomanNumeralSymbol.allCases {
            guard let startingIndex = converted.numerals.firstIndex(of: romanNumeral) else {
                continue
            }

            let numeralCount = countConsecutiveRomanNumerals(converted, startingIndex: startingIndex)
            let endingIndex = startingIndex + numeralCount
            
            guard numeralCount >= 4 else {
                continue
            }
            
            if startingIndex > 0 {
                let newNotation = convertAdditiveNotationToSubtractive(repeatingSymbol: romanNumeral,
                                                                       previousSymbol: converted.numerals[startingIndex - 1])
                converted.numerals.replaceSubrange(startingIndex-1..<endingIndex, with: newNotation)
            }
            else {
                let newNotation = convertAdditiveNotationToSubtractive(repeatingSymbol: romanNumeral)
                converted.numerals.replaceSubrange(startingIndex..<endingIndex, with: newNotation)
            }
        }
        
        return converted
    }
    
    static func simplify(_ number: RomanNumeral) -> RomanNumeral {
        var simplified = number
        
        for romanNumeral in RomanNumeralSymbol.allCases {
            guard let startingIndex = simplified.numerals.firstIndex(of: romanNumeral),
                  let endingIndex = simplified.numerals.lastIndex(of: romanNumeral) else {
                continue
            }
            
            let simplifiedNumerals = simplifyConsecutiveRomanSymbols(romanNumeral: romanNumeral,
                                                                     count: simplified.numerals.filter{$0 == romanNumeral}.count)
            simplified.numerals.replaceSubrange(startingIndex...endingIndex, with: simplifiedNumerals)
        }
        
        
        return simplified
    }
}
