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
    
    override func viewDidLoad() {
        var clientId: String = Bundle.main.infoDictionary?["ClientId"] as! String
        clientId = clientId.replacingOccurrences(of: "\"", with: "")
        let callbackUrl = "brc://validate"
        let scopes = ["read", "mysubreddits", "account"]
        
        let authUrl = AccountController.generateAuthUrl(clientId: clientId, redirectUrl: callbackUrl, scopes: scopes)
        guard let url = authUrl else {
            return
        }
        
        webView!.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if(navigationAction.request.url != nil &&
            navigationAction.request.url?.scheme == "brc") {
            print("done! let's go!")
        }
        decisionHandler(.allow)
    }
}
