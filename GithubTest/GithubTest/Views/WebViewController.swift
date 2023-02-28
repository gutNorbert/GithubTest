//
//  WebViewController.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 2/1/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Crash the app if we give a false URL manually
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = false
    }
    
}
