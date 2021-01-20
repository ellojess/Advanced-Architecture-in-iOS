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
let settinngFactory = SettingsComponentFactory()
menuFactory.createView(component: .label)
menuFactory.createView(component: .button)
menuFactory.createView(component: .image)
