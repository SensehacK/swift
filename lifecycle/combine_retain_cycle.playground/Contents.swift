import UIKit
import Combine
import Foundation


class RetainViewModel {
    
    var cancellable: AnyCancellable?
    
    init() {
        
        
        
    }
    
    func initializeTimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink {
                // [weak self] in
//                 [unowned self] in
                print("In Closure - Sink Block")
                self.printDate($0)
            }
    }
    
    
    
    func printDate(_ date: Date) {
        print(date)
    }

}


var vm: RetainViewModel? = RetainViewModel()
vm?.initializeTimer()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    print("Nullifying the object in Combine stream subscriber")
    vm = nil
}
