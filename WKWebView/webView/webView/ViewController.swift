//
//  ViewController.swift
//  webView
//
//  Created by Kautilya Save on 10/27/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://costco.com") else { return }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }


}


extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        let path = url.path
        
        if path.contains(navigationRoute.warehouse.rawValue) {
            print("Hello Warehouse")
            
            WashingtonFetcher.fetchWashington(apiMethod: .snoqualmie, completion: { [weak self] result in
                switch result {
                case .success(let data):
                    print("Data")
                    print(data.mountainPassName)
                    print(data.roadCondition)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            })
        }
        else if path.contains(navigationRoute.account.rawValue) {
            print("Account")
            WashingtonFetcher.fetchWashington(apiMethod: .stevensPass, completion: { [weak self] result in
                switch result {
                case .success(let data):
                    print("Data")
                    print(data.mountainPassName)
                    print(data.roadCondition)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            })
        }
        
        decisionHandler(.allow)
    }
    
}


enum navigationRoute: String  {
    case warehouse = "/warehouse-locations"
    case account = "/AccountHomeView"
}
