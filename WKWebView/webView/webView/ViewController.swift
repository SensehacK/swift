//
//  ViewController.swift
//  webView
//
//  Created by Kautilya Save on 10/27/22.
//

import UIKit
import WebKit


// Controller

class ViewController: UIViewController {
    // UI view file
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
    
    func loadWebView() {
        guard let url = URL(string: AppConstants.mainURL.rawValue) else { return }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
    func setupUI() {
        view.addSubview(webView)
        webView.frame = view.bounds
    }
    
    func setupConstraints() {
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
