import Darwin

print("Hello Sensehack")
//if Bool.random() {
//    print("Success")
//    //    exit(EXIT_SUCCESS)
//} else {
//    print("Failure")
//    exit(EXIT_FAILURE)
//}
//

// Getting command line arguments
//let arguments: [String] = Array(CommandLine.arguments.dropFirst())

//guard let name: String = arguments.first else {
//    exit(EXIT_FAILURE)
//}
//
//print("Hello \(name)")
//

// User input halt - Java buffered Reader
//print("What's your name?")
//
//guard let name2 = readLine(), !name.isEmpty else { exit(EXIT_FAILURE) }
//
//print("Hello \(name2)")


// Importing process info - environment variables
/*
import Foundation

let environment: [String: String] = ProcessInfo.processInfo.environment

if let secret = environment["MYSECRET"] {
    print(secret)
}
 */

// Chaining messages input which is the output of previous script
/*
import Foundation

let standardInput: FileHandle = .standardInput

if let input = String(data: standardInput.availableData, encoding: .utf8) {
    print("##" + input)
}

*/


// Output to next script input
/*
import Foundation
 
let standardOutput: FileHandle = .standardOutput
 
if let outputData = "Die Hippie Die".data(using: .utf8) {
    standardOutput.write(outputData)
 }
 
*/


// Asynchronous execution in scripts

 /*

import Foundation

let url = URL(string: "https://api.github.com/users/SensehacK")!
let request = URLRequest(url: url)
URLSession.shared.dataTask(with: request) { data, _, error in
    if let data = data {
        let responseText = String(data: data, encoding: .utf8)!
        print(responseText)
        exit(EXIT_SUCCESS)
    } else {
        print(error!.localizedDescription)
        exit(EXIT_FAILURE)
    }
}.resume()

RunLoop.current.run() // Or dispatchMain()
  */


// Argument Parser example
 /*
import ArgumentParser

struct Swifty: ParsableCommand {
    
    @Option(help: "Specify your name.")
    var name: String
    
    
    func run() throws {
        if name == "Kyle" {
            print("Hey Jew!") // Southpark reference don't cancel me :P
        } else if name == "Kenny" {
            print("They killed Kenny!")
            print("You bastards 🤬🤬🤬")
        }
        
        else {
            print("Aloha \(name)")
        }
        
    }
    
}

// Initializing the parser.
Swifty.main()

*/

// Progress Bar
 /*
import Darwin
import TSCBasic
import TSCUtility

let animation = PercentProgressAnimation(
    stream: stdoutStream,
    header: "Loading Awesome Stuff ✨")

for i in 0..<100 {
    let second: Double = 1_000_000
    usleep(UInt32(second * 0.05))
    animation.update(step: i, total: 100, text: "Loading..")
}

animation.complete(success: true)
print("Done! 🚀")


*/


// Colors in terminal
// /*

import TSCBasic

let terminalController = TerminalController(stream: stdoutStream)

let colors: [TerminalController.Color] = [
    .noColor, .red, .green, .yellow, .cyan, .white, .black, .grey
]

for color in colors {
    terminalController?.write("Hello World", inColor: color, bold: true)
    terminalController?.endLine()
}


// */
