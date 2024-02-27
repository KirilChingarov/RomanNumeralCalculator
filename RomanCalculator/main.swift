//
//  main.swift
//  RomanCalculator
//
//  Created by Kiril Chingarov on 25.02.24.
//

let calculator = RomanCalculator()

while true {
    print("Enter Roman Numeral Expression: ( XXX - I )")
    
    guard let input = readLine(),
          let romanNumeralExpression = InputParser.parseMathematicalExpression(from: input) else {
        print("Please enter valid Roman Numeral Expression")
        continue
    }
    
    let result = calculator.executeExpression(expression: romanNumeralExpression)
    print("Result: \(result.toString())")
    
    print("Continue... y/n")
    if let continueInput = readLine(),
       continueInput == "n" {
        break
    }
}
