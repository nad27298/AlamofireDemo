//
//  WebViewViewController.swift
//  Alamofire5
//
//  Created by daona on 10/11/2021.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    var url: String = ""

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WebView"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        wkWebView.navigationDelegate = self
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        guard let url = URL(string: self.url) else { return }
        wkWebView.load(URLRequest(url: url))
        wkWebView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
    
    func webView(webView: WKWebView!, createWebViewWithConfiguration configuration: WKWebViewConfiguration!, forNavigationAction navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            wkWebView.load(navigationAction.request)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
}
