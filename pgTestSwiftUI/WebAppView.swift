//
//  WebAppView.swift
//  pgTestSwiftUI
//
//  Created by Taesup Yoon on 2022/06/09.
//

import SwiftUI
import Bootpay
import BootpayUI

struct WebAppView: View {
    var body: some View {
        VStack {
            BootpayUIWebView(url: "https://www.naver.com")
        }
    }
} 



struct BootpayUIWebView: UIViewRepresentable {
    var urlString: String
    
    public init(url: String) {
        self.urlString = url
    }
    
    public func makeUIView(context: Context) -> BootpayWebView {
        let webView = BootpayWebView()
        
        
        if let url = URL(string: urlString) {
            webView.webview.load(URLRequest(url: url))
        }
        
       return webView
    }
    
    public func updateUIView(_ view: BootpayWebView, context: Context) {
    }
}
