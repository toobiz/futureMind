//
//  WebViewController.swift
//  FutureMind
//
//  Created by Michal Tubis on 14.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class WebViewController: UIViewController {

    var viewModel: WebViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.urlString.asObservable().subscribe(onNext: { [unowned self] string in
            guard let urlString = string else { return }
            self.webView.load(URLRequest(url: URL(string: urlString)!))
        }).disposed(by: disposeBag)
    }
    
    func setupWebView() {
//        webView = WKWebView(frame: webViewContainer.bounds, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
//        webViewContainer.addSubview(webView)
        webView.scrollView.clipsToBounds = false
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
}
