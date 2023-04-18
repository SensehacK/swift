//
//  ViewController.swift
//  combine-uikit
//
//  Created by Kautilya Save on 4/18/23.
//

import UIKit
import Combine

extension Notification.Name {
    static let newPost = Notification.Name("newPost")
}

struct BlogPost {
    let title: String
}

class ViewController: UIViewController {
    
    
    // UI Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    
    var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mainButton.addTarget(self, action: #selector(mainButtonPressed), for: .primaryActionTriggered)
        setupPublisherSubscriber()
        
    }
    
    func setupPublisherSubscriber() {
        // publisher
        
        let publisher = NotificationCenter
            .Publisher(center: .default, name: .newPost, object: nil)
            .map { (notication) -> String? in
                return (notication.object as? BlogPost)?.title ?? ""
            }
            
        
        // subscriber Option 1
//        let subscriber = Subscribers.Assign(object: mainLabel, keyPath: \.text)
//        publisher.subscribe(subscriber)
        
        // vs Option 2
        publisher.sink { val in
            self.mainLabel.text = val
        }
        .store(in: &cancellable)
        
        /* You can't use
        let anycancel = publisher.sink { val in
                self.mainLabel.text = val
        }
        Since the closure is a function which is of type reference.
        So it would just not hold the reference of self to even subscribe to the publisher. As we are still in function scope of `setupPublisherSubscriber`
        Even though we didn't use [weak self] and opted for strong reference it won't subscribe unless the `AnyCancellable` returned by `sink` or `assign(to:)` isn't hold on class level reference.
        
         */
        
        
    }
    
    
    
    @objc func mainButtonPressed() {
        let title = mainTextField.text ?? "Hi Kautilya!"
        print(title)
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newPost, object: blogPost)
        
    }
    


}

