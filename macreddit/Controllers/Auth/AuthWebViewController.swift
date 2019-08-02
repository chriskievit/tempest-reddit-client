//
//  AuthWebViewController.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import WebKit

class AuthWebViewController: NSViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView?
    
    var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        guard let url = viewModel.authUrl() else {
            return
        }
        
        webView!.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if(navigationAction.request.url != nil &&
            navigationAction.request.url?.scheme == "brc") {
            viewModel.validateToken(callbackUrl: navigationAction.request.url!)
            decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
}
