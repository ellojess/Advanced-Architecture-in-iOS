//: [Previous](@previous)

import Foundation

//: # FlatMap
//: #### Exercise 1
/*: Consider the scenario where we want to transform an optional String to an optional `URL` and we try to use `map`.
*/
let receivedData = ["url" :"https://www.google.com"]
let path: String? = receivedData["url"]
let url = path.map { (string: String) -> URL? in
    let url = URL(string: string)
    return url
}
print(url)
//: What happened? How can you explain it? Write your answer in a comment and talk about how you would safely access the url.
// The URL was still fetched and returned as an optional. Since it's an optional, I would have unwrapped the optional as to safely access the URL

//: Here's an alternative you can do to remove the nesting of optionals using flatmap
let url2 = path.flatMap { (string: String) -> URL? in // We return URL? again
    return URL(string: string) // We return an optional URL
}
print(url2)

/*:
We return a `URL?` again in the `flatMap` function. The closure is still the same but we also "flattened" after the transformation. This removed one layer of optional nesting.

`flatMap` first performs a map, and then it flattens the optional. By using it, you transform optionals while avoiding force unwrapping.
*/
//: #### Exercise 2
/*:
`flatMap` isn’t reserved just for optionals, but for collections as well. It can flatten a nested collection after a mapping operation.
 
Here's an example of how it works. We transform an array of arrays and flatten it into a single array:
*/
let numbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let result = numbers.flatMap({ $0 })
print(result)
//: Now take the following and return an array with the tallest giraffes
let giraffes = [[5, 6, 9], [11, 2, 13, 20], [1, 13, 7, 8, 2]]
var giraffesResult = giraffes.flatMap({ $0 }) // flatten nexted collection
giraffesResult.sort() // sort in ascending heights
let tallestGiraffes = giraffesResult.suffix(3) // get last 3 elements (ie tallest giraffes)
print(tallestGiraffes) // print tallest giraffes

// consolidated solution
var giraffesResult2 = giraffes.flatMap({ $0 }).sorted().suffix(3)
print(giraffesResult2)

// alt solution returns max in each sub array
var giraffesResult3 = giraffes.flatMap({ $0.max()})
print(giraffesResult3)
//: #### Exploring combinations
/*:
We can combine `flatMap` and  `map` to create powerful transformations. Let's say we need to create a deck of cards
*/
let suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
let faces = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

var deckOfCards = suits.flatMap { suit in
    faces.map { face in
        (suit, face)
    }
}
deckOfCards.shuffle()
print(deckOfCards)
//: #### Exercise 3
/*:
Write a function that duplicates each value inside an array. See if you can use map or flatMap for this.

For example `[1,2,3]` turns into `[1, 1, 2, 2, 3, 3]` and `[["a", "b"],["c", "d"]]`, turns into `[["a", "b"], ["a", "b"], ["c", "d"], ["c", "d"]]`
*/
let letters = [["a", "b"],["c", "d"]]
let nums = [1, 2, 3]

print(nums.map({[$0, $0]}).flatMap({$0}))
print(letters.map({ [$0, $0]}).flatMap({$0}))

// func w/ generic type to take in any value
func duplicates<T>(values: [T]) -> [T] {
    return values.map({[$0, $0]}).flatMap({$0})
}

print(duplicates(values: letters))
//: [Next](@next)
