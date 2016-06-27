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

// Friday whiteboarding with Sean

func random(longLink: String, length: Int) -> String {
    let base = longLink
    var shortLink: String = ""
    
    for _ in 0..<length {
        let randomChar = arc4random_uniform(UInt32(base.characters.count))
        shortLink += "\(base[base.startIndex.advancedBy(Int(randomChar))])"
    }
    return shortLink
}

var links = [String : String]()

func generate(longLink: String) -> String {
    var count = 0
    let shortLink = links[longLink]
    
    if shortLink == nil {
        links[longLink] = random(longLink, length: 6)
        count += 1
    }
    
    for (key, value) in links {
        if longLink == key {
            links.removeValueForKey(value)
            links[longLink] = value
            return value
        } else if value == shortLink {
            generate(longLink)
        }
    }
    
    if count >= 100 {
        links.removeValueForKey(shortLink!)
    }

    return shortLink!
}

// tests
generate("www.facebook.com")
generate("www.facebook.com")
generate("www.facebook.com")
generate("www.facebook.com")
generate("www.linkedin.com")

print(links)



