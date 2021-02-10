import UIKit

// activity: https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/09-Functional-ProgrammingPt.1/assignments/activity.md

// MARK: 1 Imperative vs Declarative
// imperative version
func doubleIt(inputArray: Array<Int>) {

    var results = [Int]()

    for num in inputArray {
        results.append(num * 2)
    }
    print(results)
}

doubleIt(inputArray: [1,2,3]) // [2,4,6]

// declarative functional programming version
extension Array where Element == Int {
    
    func timesTwo() -> [Int] {
        var result = [Int]()
        
        for num in self {
            result.append(num*2)
        }
        return result
        
    }
}

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let output = numbers.timesTwo()
print(output)

//MARK: 2 return all swift files using HOF
let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]
var filtered = exampleFiles.filter{$0.contains("swift")}

print(filtered)

// alt solution
func getSwiftFiles(inputArray: Array<String>) -> [String] {
    return inputArray.filter({$0.hasSuffix(".swift")})
}
getSwiftFiles(inputArray: exampleFiles)

// MARK: 3 Define a function that sums all the integers in an array.
print("Sum of numbers in array is ", numbers.reduce(0) {return $0 + $1})


// MARK: 4 Print a list of cities with at least one million inhabitants, together with their total populations.
struct City {
  let name: String
  let population: Int
}

extension City {
  func scalingPopulation() -> City {
    return City(name: name, population: population * 1000)
  }
}

let paris = City(name: "Paris", population: 22410)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

let filteredCities = cities.filter{$0.population >= 1000000}.map {$0.scalingPopulation()}

filteredCities.reduce("") { result, city in
    return "\(result)  \(city.name): \(city.population)"
}

//print(filteredCities.map{$0.name})
//print(filteredCities.map{$0.population})
