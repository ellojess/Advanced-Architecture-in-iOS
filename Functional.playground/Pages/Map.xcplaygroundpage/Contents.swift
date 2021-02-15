
import Foundation

//: # Map
//: #### Exercise 1
/*: Taking a collection of data to transform it is a common task any iOS dev must do.
 
Take for example an array of students and their attendance to a course.
*/
let attendance = [
    (name: "Adriana", sessions: 8),
    (name: "Mitchell", sessions: 10),
    (name: "Joi", sessions: 13),
    (name: "Ian", sessions: 14),
    (name: "Jess", sessions: 0),
]
/*:
How would you transform the data to present readable sentences of their status in the course stored in an array?
 
Take the following conditions:
- If a student has <12 they are at risk
- Any other case, they are on track
 
Expected result:
 
["Adriana is at risk", "Mitchell is at risk", "Joi is on track", "Ian is on track"]
*/
//Iterative version
for student in attendance {
    if student.sessions < 12{
        print("\(student.name) is at risk")
    } else {
        print("\(student.name) is on track")
    }
}


//Functional version
func isAtRisk(attendance:[(String, Int)]) -> [String] {
    return attendance.map{(name, sessions) -> String in
        if sessions < 12 {
            return "\(name) is at risk"
        } else {
            return "\(name) is on track"
        }
    }
}

// alt solution
//attendance.map{ $0.sessions < 12 ? "\($0.name) is at risk" : "\($0.name) is on track"}

print(isAtRisk(attendance: attendance))
/*:
 Now you need a function that takes students and their attendance and return only the session value, sorter and with zeros filtered out (most likely those students withdrew).
*/

//Functional approach, try chaining functions together with a pipeline.

func sessionsSort(attendance:[(String, Int)]) -> [Int] {
    return attendance.map{$0.1}.filter{$0 > 0}.sorted(by: >)
}

print(sessionsSort(attendance: attendance))
//: #### Exercise 2
/*:
Create a function that transforms the values in a dictionary for books. Each rating needs to be turned into human readable format.
*/
let bookRatings: [String : Float] = ["Atomic Habits" : 5.0, "Getting Things Done" : 4.5, "Grit" : 4.0, "The Lean Startup" : 3.9]

func rateBook(bookRatings: [String:Float]) -> [String] {
    return bookRatings.map{(book, rating) -> String in
        if rating >= 4.0 {
            return "\(book) is a great read!!"
        }
        if rating >= 2.0 && rating <= 4.0 {
            return "\(book) is a okay read"
        }
        if rating <= 2.0 {
            return "\(book) is a bad read"
        } else {
            return "\(book) has not been rated"
        }
    }
}


// alt solution
func rateBook1(bookRatings: [String:Float]) {
    bookRatings.map({print("\($0.key) has rating of \($0.value)")})
}


// helper for alt solution
func convertRating(dict: [String: Float]) -> [String:String] {
    return dict.mapValues{(rating) -> String in
        switch rating {
        case ..<1: return "Very weak"
        case ..<2: return "Weak"
        case ..<3: return "Good"
        case ..<4: return "Great"
        case ..<5: return "Excellent"
        default: return "Unknown"
        }
    }
}


//: #### Exercise 3
/*:
The following code gets the street and city and cleans up the strings. See if you can reduce the code using map.
*/
let contact = ["address": ["zipcode": "94109","street":"post","city": "san francisco"]]

func capitalizedAndTrimmed(_ string: String) -> String {
    return string.trimmingCharacters(in: .whitespaces).capitalized
}

var capitalizedStreet: String? = nil // contact["address"]["street"].map(capitalizedAndTrimmed)
var capitalizedCity: String? = nil

if let address = contact["address"] {
    if let street = address["street"] {
        capitalizedStreet = capitalizedAndTrimmed(street.capitalized)
    }
    if let city = address["city"] {
        capitalizedCity = capitalizedAndTrimmed(city.capitalized)
    }
}

print(capitalizedStreet)
print(capitalizedCity)

// Cleaned up version
var cleanedStreet: String? = nil
var cleanedCity: String? = nil

contact["address"].map{
    cleanedStreet = capitalizedAndTrimmed($0["street"]!)
    cleanedCity = capitalizedAndTrimmed($0["city"]!)
}

print(cleanedStreet)
print(cleanedCity)
//: [Next](@next)
