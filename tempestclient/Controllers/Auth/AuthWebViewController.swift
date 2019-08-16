//
//  AuthWebViewController.swift
//  tempestclient
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import WebKit

class AuthWebViewController: NSViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView?
    
    var viewModel: AuthViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        guard let url = viewModel.authUrl() else {
            return
        }
        
        webView!.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
            url.scheme == "brc" {
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            let query: URLQueryItem? = urlComponents?.queryItems?.first(where: { $0.name == "code" })
            
            if let query = query {
                viewModel.authenticate(code: query.value!) { (result: Result<Bool, RequestError>) in
                    switch result {
                    case .success(_):
                        self.handleSuccessfulAuth()
                        break;
                    case .failure(let error):
                        self.handleFailedAuth(error: error)
                        break;
                    }
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    private func handleSuccessfulAuth() { }
    private func handleFailedAuth(error: Error) { }
}
