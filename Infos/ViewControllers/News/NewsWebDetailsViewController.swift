//
//  NewsWebDetailsViewController.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import UIKit
import WebKit

class NewsWebDetailsViewController: BaseViewController {
    
    // MARK: UI elements
    var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

extension NewsWebDetailsViewController: WKNavigationDelegate {
    
}
