//: Playground - noun: a place where people can play

import UIKit

// Write a function that determines how many words there are in a sentence
func wordCount(string: String) -> Int {
    let sentence = string.componentsSeparatedByString(" ")
    return sentence.count
}

let string = "How many words are here?"
wordCount(string)

// Write a function that returns all the odd elements of an array
func isOdd(data: [Int]) -> [Int] {
    var odd = [Int]()
    for num in data {
        if !(num % 2 == 0) {
        odd.append(num)
        }
    }
    return odd
}

let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
isOdd(array)

// Write a function that computes the list of the first 100 Fibonacci numbers.

func fibonacci() -> [Double] {
    var results = [Double]()
    var num1: Double = 0
    var num2: Double = 1
    results.append(num1)
    results.append(num2)
    
    while results.count < 100 {
        let sum = num1 + num2
        let new = sum
        results.append(new)
        num1 = num2
        num2 = new
    }
    
    return results
}

fibonacci()



