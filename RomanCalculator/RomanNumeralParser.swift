//
//  RomanNumeralParser.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 25.02.24.
//

class RomanNumeralParser {
    static private func parseRomanNumeralFromCharacter(_ char: Character) -> RomanNumeralSymbol? {
        return RomanNumeralSymbol(rawValue: char.uppercased())
    }

    static func parseRomanNumerals(from input: String) -> RomanNumeral {
        var romanNumeral: RomanNumeral = RomanNumeral()
        
        for character in input {
            if let numeral = parseRomanNumeralFromCharacter(character) {
                romanNumeral.numerals.append(numeral)
            }
        }
        
        return romanNumeral
    }
}
