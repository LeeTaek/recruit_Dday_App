//
//  webView.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//
import WebKit
import SwiftUI


struct Webview: UIViewRepresentable {
   
    var urlToLoad: String
    
    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        // unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        
        // 웹뷰 인스턴스 생성
        let webview = WKWebView()
        
        // 웹뷰를 로드한다.
        webview.load(URLRequest(url: url))
        
        return webview
        
    }
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Webview>) {
           
       }
    
}


struct Webview_Previews: PreviewProvider {
    static var previews: some View {
        Webview(urlToLoad: "https://www.naver.com")
    }
}
