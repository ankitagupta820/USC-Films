//
//  HTMLView.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/21/21.
//


import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable{
    
    let htmlString: String
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}
