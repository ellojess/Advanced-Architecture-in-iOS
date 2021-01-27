import UIKit

/// Practicing with the Adapter pattern: https://github.com/Make-School-Courses/MOB-2.4-Advanced-Architectural-Patterns-in-iOS/blob/master/Lessons/05-Structural-PatternsPt.1/assignments/adapter.md

enum MediaType {
    case mp4, mp3, acc, mov, wav
}

// Target protocol 1
protocol Player {
    associatedtype Media
    func play(mediaType: Media, fileName: String)
}

// Target protocol 2

    //TODO: Implement a Pause protocol with a pause() function that accepts 1 parameter: A String called "fileName"
protocol Pause {
    func pause(fileName: String)
}


// Adaptee 1
class AudioPlayer {
    func playAudio(fileName: String) {
        print("Now Playing: ", fileName)
    }
}

// Adaptee 2
class VideoPlayer {
    func playVideo(fileName: String) {
        print("Now Playing: ", fileName)
    }
}

// Adapter (class)
class MyPlayer: Player {

    //TODO: create required player variables
    var videoPlayer = VideoPlayer()
    var audioPlayer = AudioPlayer()

    func play(mediaType: MediaType, fileName: String) {
        if (mediaType == .mov){
            videoPlayer.playVideo(fileName: fileName);
        }else if(mediaType == .mp4){
            audioPlayer.playAudio(fileName: fileName);
        }
    }
}

// Adapter (class extension)

    //TODO: Implement a class extension which adds Pause functionality to MyPlayer
extension MyPlayer: Pause {
    func pause(fileName: String) {
        print("\(fileName) is now paused...")
    }
}


// Usage
let myPlayer = MyPlayer()
myPlayer.play(mediaType: .acc, fileName: "Titanium.aac")
myPlayer.play(mediaType: .mp4, fileName: "Cat_riding_a_roomba.mp4")
myPlayer.pause(fileName: "Cat_riding_a_roomba.mp4")


/* This should print:
 Now Playing:  Titanium.aac
 Now Playing:  Cat_riding_a_roomba.mp4
 Cat_riding_a_roomba.mp4  is now paused...
 */
