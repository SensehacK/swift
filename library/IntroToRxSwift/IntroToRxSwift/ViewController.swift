//
//  ViewController.swift
//  IntroToRxSwift
//
//  Created by Kautilya Save on 12/17/21.
//

import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rxSwiftRelays()
    }


    func rxSwiftRelays() {
        print("Example of Swift Relays")
        let disposeBag = DisposeBag()
        
        let relay = PublishRelay<String>()
        
        relay.accept("Knock knock, anyone home?")
        
        relay
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        relay.accept("1")
        
    }
    
}

