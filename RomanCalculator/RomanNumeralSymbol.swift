//
//  RomanNumeralSymbol.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 25.02.24.
//

enum RomanNumeralSymbol: String, CaseIterable {
    case I = "I"
    case V = "V"
    case X = "X"
    case L = "L"
    case C = "C"
    case D = "D"
    case M = "M"
    
    func toString() -> String {
        return self.rawValue
    }
    
    func toInt() -> Int {
        switch self {
        case .I:
            return 1
        case .V:
            return 5
        case .X:
            return 10
        case .L:
            return 50
        case .C:
            return 100
        case .D:
            return 500
        case .M:
            return 1000
        }
    }
}

extension RomanNumeralSymbol: Comparable {
    
    static func < (lhs: RomanNumeralSymbol, rhs: RomanNumeralSymbol) -> Bool {
        return lhs.toInt() < rhs.toInt()
    }
}
