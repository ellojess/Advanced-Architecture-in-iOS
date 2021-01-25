import UIKit

///Chain Of Responsibility: https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/03-Behavioral-PatternsPt.1/assignments/chain2.md

struct Message {
    let from: String
    let to: String
    let subject: String
}

class Transmitter {
    var nextLink: Transmitter?
    required init() {}
    func sendMessage(message:Message) {
        if (nextLink != nil) {
            nextLink!.sendMessage(message: message)
        } else {
            print("End of chain reached. Message not sent")
        }
    }

    class func matchEmailSuffix(message:Message) -> Bool {
      // TODO: Refactor time. Put your logic used before in this new method
        let splitEmail = message.to.components(separatedBy: "@")
        if let domain = splitEmail.last {
            if domain.contains("students") {
                return false
            } else {
                return true
            }
        }
        fatalError()
    }

    class func createChain() -> Transmitter? {
        let transmitterClasses:[Transmitter.Type] = [ PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self
        ]
        var link:Transmitter?
        for tClass in transmitterClasses.reversed() {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }
        return link
    }
}

class LocalTransmitter: Transmitter  {
    override func sendMessage(message: Message) {
        if (Transmitter.matchEmailSuffix(message: message)) {
            print("Message to \(message.to) sent locally")
        } else {
            super.sendMessage(message: message);
        }
    }
}

class RemoteTransmitter: Transmitter {
    override func sendMessage(message: Message) {
        if (!Transmitter.matchEmailSuffix(message: message)) {
            print("Message to \(message.to) sent remotely")
        } else {
            super.sendMessage(message: message)
        }
    }
}


class PriorityTransmitter: Transmitter {
    override func sendMessage(message: Message) {
        if (message.subject.hasPrefix("Priority")) {
            print("Message to \(message.to) sent as priority")
        } else {
            super.sendMessage(message: message)
        }
    }
}

// mock messages data
let messages = [
    Message(from: "adriana@ms.com", to: "mitchell@ms.com", subject: "MOB Courses"),
    Message(from: "adriana@ms.com", to: "jess@students.com", subject: "TA Updates"),
    Message(from: "ashu@ms.com", to: "all@ms.com", subject: "Priority: All-Hands Meeting")
]

// Business rules:
// Messages are sent locally if it happens within a company. This means their email addresses end the same.
// Messages are sent remotely if they are sent to someone outside the company. This means their email addresses end different.

// Creating the transmitter
let localT = LocalTransmitter()
let remoteT = RemoteTransmitter()

// Processing each message
for msg in messages {
    if msg.to.contains("ms.com"){
        localT.sendMessage(message: msg)
    } else {
        remoteT.sendMessage(message: msg)
    }
}

if let chain = Transmitter.createChain() {
    for msg in messages {
        chain.sendMessage(message: msg)
    }
}


/// Command Pattern: https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/03-Behavioral-PatternsPt.1/assignments/command.md

// Receiver
class TelevisionControl {
   func turnOn() {
       print("Turning On TV")
   }
   func turnOff() {
     print("Turning Off TV")
   }
}

// Command
protocol TelevisionCommand {
   func execute()
}

class TurnOnTelevision: TelevisionCommand {

  // TODO: Complete implementation...
    public let televisionControl: TelevisionControl

    public init(_ televisionControl: TelevisionControl) {
        self.televisionControl = televisionControl
    }
    public func execute() {
        self.televisionControl.turnOn()
    }

}

class TurnOffTelevision: TelevisionCommand {
   public let televisionControl: TelevisionControl

   public init(_ televisionControl: TelevisionControl) {
       self.televisionControl = televisionControl
   }
   public func execute() {
       self.televisionControl.turnOff()
   }
}

// Invoker
class RemoteControl {

   public let televisionControl: TelevisionControl

   // TODO: create Init()
    init(televisionControl: TelevisionControl) {
        self.televisionControl = televisionControl
    }

   func execute(_ command: TelevisionCommand) {

    // TODO: complete execute() function
    command.execute()

   }

}

let televisionControl = TelevisionControl()
let remoteControl = RemoteControl(televisionControl: televisionControl)
let turnOffTelevision = TurnOffTelevision(televisionControl)
remoteControl.execute(turnOffTelevision)

///Key Value Observer (KVO) : https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/04-Behavioral-PatternsPt.2/assignments/kvo.md

/* Step 1: Create a Subject class and Annotate a Property for Key-Value Observing */

//TODO: Create Subject class...
class Subject: NSObject {
    @objc dynamic var counter = 0
    
}


/* Step 2: Define an Observer class */
class Observer : NSObject {

    //TODO: Add init()
    init(subject:Subject) {
          super.init()
          subject.addObserver(self, forKeyPath: "counter",
                              options: NSKeyValueObservingOptions.new, context: nil)
      }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        print("Notification: \(String(describing: keyPath)) = \(String(describing: change?[NSKeyValueChangeKey.newKey]!))");

    }
}
/* Step 3: Associate the Observer with the Property to Observe */
let subject = Subject()
let observer = Observer(subject: subject)

/* Step 4: Respond to a Property Change */
subject.counter += 11
subject.counter = 99

/* RESULTS - Should print:
Notification: Optional("counter") = Optional(11)
Notification: Optional("counter") = Optional(99)
*/
