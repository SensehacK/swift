//
//  RetainViewModel.swift
//  Retain_Cycle
//
//  Created by Kautilya Save on 5/17/23.
//

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
                 [unowned self] in // This or Weak self could be used to
                // make sure that strong reference is not hold / retained.
                // It also doesn't show up on Instruments with mallocs, leaks stack trace.
                print("Hello")
                self.printDate($0)
            }
    }
    
    
    
    func printDate(_ date: Date) {
        print(date)
    }

}
