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
    
    var progressView: UIProgressView!
    
    //var websites = ["https://lambdaschool.com/lambda-students/audrey-welch", "https://www.linkedin.com/in/audrey-welch-ios/"]
    var websites = ["apple.com", "hackingwithswift.com"]
    
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
        
        // Add a Key Value Observer
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        // Create a UIProgressView instance with the default style
        progressView = UIProgressView(progressViewStyle: .default)
        
        // Tell progress view to set its layout size so that it fits its contents fully
        progressView.sizeToFit()
        
        // Create a new bar button item using the customView parameter, to wrap the progress view into a bar button item so that it can go inside the toolbar
        let progressButton = UIBarButtonItem(customView: progressView)
        
        // Flexible space takes up as much room as it can on the left
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        // Create an array containing the flexible space and the refresh button and set it to the view controller's toolbarItems array
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // Create a URL
        let url = URL(string: "https://" + websites[0])!
        
        // Create a new URLRequest object from the URL and give it to the webView to laod
        webView.load(URLRequest(url: url))
        
        // Enable a property on web view that allows users to swipe from left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped() {
        
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // Alternative to the below individual adds, but I don't want to display the whole website url because it's too long
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
//        ac.addAction(UIAlertAction(title: "Showcase", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "LinkedIn", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        
        let url = URL(string: "https://" + action.title!)!
        
        webView.load(URLRequest(url: url))
        
//        if action.title == "Showcase" {
//            let url = URL(string: "https://lambdaschool.com/lambda-students/audrey-welch")!
//            webView.load(URLRequest(url: url))
//        } else if action.title == "LinkedIn" {
//            let url = URL(string: "https://www.linkedin.com/in/audrey-welch-ios/")!
//            webView.load(URLRequest(url: url))
//        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // Decide whether we want to allow navigation to happen or not each time something happens
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // @escaping acknowledges that the closure might be used later
        // Evaluate URL that users click on to see if it's safe, then call decisionHandler with a negative or positive answer
        
        // Set constant url to be equal to the URL of the navigation
        let url = navigationAction.request.url
        
        // Unwrap the value of the optional url.host
        if let host = url?.host {
            // Loop through all sites on our safe list, placing the name of the site in the website variable
            for website in websites {
                // See whether each safe website exists somewhere in the host name
                if host.contains(website) {
                    // If website was found, call the decision handler with a positive response - allow loading
                    decisionHandler(.allow)
                    // Exit the method
                    return
                }
            }
        }
        // If no host set, or if we've gone through all the loop and found nothing, we call the decision handler with a negative response - cancel loading
        decisionHandler(.cancel)
    }
}

