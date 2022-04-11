/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/working-with-strings

import Foundation
import UIKit


let input = "a b c"

let words = input.components(separatedBy: " ") // ["a", "b", "c"]
print(words)

let newLineInput = """
A
B
C
"""

let newWords = newLineInput.components(separatedBy: " ") // ["A\nB\nC"]
print(newWords)


let randomLetter = words.randomElement()

/// `trimmingCharacters(in:)`
/// asks Swift to remove certain kinds of characters from the start and end of a string.

let helloWorld = "    hello World  "
print(helloWorld)

let helloWorldTrimmed = helloWorld.trimmingCharacters(in: .whitespacesAndNewlines)
print(helloWorldTrimmed)


/// Checking for misspelled words;
/// Checking a string for misspelled words takes four steps in total.
/// `STEP 1`
/// First, we create a word to check
/// and an instance of `UITextChecker` that we can use to check that string:

let wordToCheck: String = "hello"
let uiTextChecker = UITextChecker.init()

/// `STEP 2`
/// Second, we need to tell the checker how much of our string we want to check.

let nsRange = NSRange(location: 0, length: wordToCheck.utf16.count)

/// NOTE: We need to ask Swift to create an Objective-C string range
/// using the entire length of all our characters,.
/// The reason is because Objective C does not have a way to deal with special String characters like emojis.

/// `STEP 3`
/// Third, we can ask our text checker
/// to report where it found any misspellings in our word:

let rangeOfMispelledWords = uiTextChecker.rangeOfMisspelledWord(in: wordToCheck,
                                                                range: nsRange,
                                                                startingAt: 0,
                                                                wrap: false,
                                                                language: "en")
/// `STEP 4`
/// There is still one complexity here:
/// Objective-C didn’t have any concept of optionals,
/// so instead relied on special values to represent missing data.

let missingDataCheck = rangeOfMispelledWords.location == NSNotFound
