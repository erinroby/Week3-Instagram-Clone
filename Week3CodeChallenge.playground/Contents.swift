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