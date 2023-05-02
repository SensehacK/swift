import UIKit


protocol DataStructure {
    var count: Int { get }
    var maximumSize: Int { get }
}



// Default implementation


extension DataStructure {
    var maximumSize: Int  {
        20
    }
}


struct customData: DataStructure {
    var count: Int = 2
    
    
    static func printSomeSize() {
        let sum = 2032
        print(sum)
        
    }
    
    
}

customData().maximumSize
