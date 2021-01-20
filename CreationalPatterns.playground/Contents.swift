import UIKit

/// singleton implementation
/// singleton design pattern https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/01-Creational-PatternsPt.1/assignments/singleton.md
class DataSource {
    
    static let sharedInstance = DataSource()
    
    var creationalPatternsArray = ["Abstract Factory", "Factory Method",
                                   "Builder", "Dependency Injection", "Lazy Initialization",
                                   "Object Pool", "Prototype", "Singleton"]
    
    // use a private init to ensure only 1 instance is created
    private init() {
        // do something
        print("self is:", self)
        print("creationalPatternsArray is", creationalPatternsArray)
    }
}
print(DataSource.sharedInstance)

// instantiate the singleton object
let data = DataSource.sharedInstance


func looper(){
    
    //    for num in 1...5 {
    //        _ = DataSource.sharedInstance
    //        print("num is:", num)
    //    }
    
    for pattern in DataSource.sharedInstance.creationalPatternsArray {
        print(pattern)
    }
}

looper()



///object template pattern https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/01-Creational-PatternsPt.1/assignments/template.md
var products = [
    ("Kayak", "A boat for one person", 275.0, 10),
    ("Lifejacket", "Protective and fashionable", 48.95, 14),
    ("Soccer Ball", "FIFA-approved size and weight", 19.5, 32)]

func calculateTax(product:(String, String, Double, Int)) -> Double {
    return product.2 * 0.2;
}

func calculateStockValue(tuples:[(String, String, Double, Int)]) -> Double {
    return tuples.reduce(0, {
        (total, product) -> Double in
        return total + (product.2 * Double(product.3))
    });
}

print("Sales tax for Kayak: $\(calculateTax(product: products[0]))")
print("Total value of stock: $\(calculateStockValue(tuples: products))")



/// factory pattern activity: https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/02-Creational-PatternsPt.2/assignments/factory.md

// component types
enum ComponentType {
    case button
    case label
    case image
}


// menu items
//over simplified subclasses as examples
//when instantiated, these will be concrete products from the factory
class SettingsButton: UIButton{}
class SettingsLabel: UILabel{}
class SettingsImage: UIImageView{}

class MenuButton: UIButton{}
class MenuLabel: UILabel{}
class MenuImage: UIImageView{}

// protocol as interface for factory
// Any class that conforms to it will be able to have its own factory method and do the custom styling
protocol ComponentFactory {
    //this is the factory method
    func createView(component: ComponentType) -> UIView
}

//asks for a menu label
let menuFactory = MenuComponentFactory()
menuFactory.createView(component: .label)
menuFactory.createView(component: .button)
menuFactory.createView(component: .image)


//this class will be the creator
//it will apply logic and  decide what needs to be instantiated based on given arguments
class MenuComponentFactory: ComponentFactory {
    
    func createView(component: ComponentType) -> UIView {
        switch component {
        case .button:
            return MenuButton()
        case .label:
            return MenuLabel()
        case .image:
            return MenuImage()
        }
    }
}

// settings screen
class SettingsComponentFactory: ComponentFactory {
    func createView(component: ComponentType) -> UIView {
        switch component {
        case .button:
            return SettingsButton()
        case .label:
            return SettingsLabel()
        case .image:
            return SettingsImage()
        }
    }
}

//asks for a menu label
let settingsFactory = SettingsComponentFactory()
settingsFactory.createView(component: .label)
settingsFactory.createView(component: .button)
settingsFactory.createView(component: .image)


/// build pattern activity https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/02-Creational-PatternsPt.2/assignments/builder.md


enum BicycleSize: String {
    case small
    case medium
    case large
}

enum BicycleType : String {
    case kids
    case standard
    case mountain
}

struct Bicycle
{
    public let type: BicycleType
    public let color: UIColor
    public let size: BicycleSize
}

extension Bicycle: CustomStringConvertible {
    public var description: String {
        return type.rawValue + " bicycle"
    }
}

// Builder Protocol
protocol BikeBuilder {
    var type: BicycleType { get set }
    var color: UIColor { get set }
    var size: BicycleSize { get set }
    
    func construct() -> Bicycle
}

// MARK: - Builder
class BicycleBuilder: BikeBuilder {
    
    var type: BicycleType = .standard
    var color: UIColor = .gray
    var size: BicycleSize = .medium
    
    func construct() -> Bicycle {
        return Bicycle(type: type, color: color, size: size)
    }
}

// MARK: - Director
public class BikeAssembler {
    
    // Build a kids bike
    func createKidsBike() -> Bicycle {
        let builder = BicycleBuilder()
        builder.type = .kids
        builder.size = .small
        return builder.construct()
    }
    
    // TODO: 1) build the Mountain bike
    func createMountainBike() -> Bicycle {
        let builder = BicycleBuilder()
        builder.type = .mountain
        builder.size = .large
        return builder.construct()
    }
    
    // TODO: 2) the Standard bike
    func createStandardBike() -> Bicycle {
        let builder = BicycleBuilder()
        builder.type = .standard
        builder.size = .medium
        return builder.construct()
    }
    
}

let bikeAssembler = BikeAssembler()

let kids = bikeAssembler.createKidsBike()
print(kids.description)

let mountainBike = bikeAssembler.createMountainBike()
print(mountainBike.description)

let standardBike = bikeAssembler.createStandardBike()
print(standardBike.description)
