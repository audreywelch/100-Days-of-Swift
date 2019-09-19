//
//  ViewController.swift
//  4-Easy-Browser
//
//  Created by Audrey Welch on 9/19/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        // Create a new instance of WKWebView web browser and assign to webView property
        webView = WKWebView()
        
        // Set webView's delegate to the current view controller
        webView.navigationDelegate = self
        
        // Make the root view of the view controller the webView
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        // Create a URL
        let url = URL(string: "https://lambdaschool.com/lambda-students/audrey-welch")!
        
        // Create a new URLRequest object from the URL and give it to the webView to laod
        webView.load(URLRequest(url: url))
        
        // Enable a property on web view that allows users to swipe from left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func openTapped() {
        
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Showcase", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "LinkedIn", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        //let url = URL(string: "https://" + action.title!)!
        
        if action.title == "Showcase" {
            let url = URL(string: "https://lambdaschool.com/lambda-students/audrey-welch")!
            webView.load(URLRequest(url: url))
        } else if action.title == "LinkedIn" {
            let url = URL(string: "https://www.linkedin.com/in/audrey-welch-ios/")!
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }


}

