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
    let webview = WKWebView()

    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        // 한글 url 핸들링할 수 있도록 인코딩
        let encodedStr = urlToLoad.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // 언래핑
        guard let url = URL(string: encodedStr) else {
            return WKWebView()
        }

        // 웹뷰를 로드한다.
        webview.load(URLRequest(url: url))
        return webview
    }

    // 뒤로가기
    func goBack() {
        if webview.canGoBack {
            webview.goBack()
        }
    }

    
    // 앞으로 가기
    func goForward(){
        if webview.canGoForward {
            webview.goForward()
        }
    }
 
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Webview>) {
           
    }
    
}




struct Web: View {
    
    let webUrl: String
    let webview: Webview
    
    init(webUrl: String) {
        self.webUrl = webUrl
        self.webview = Webview(urlToLoad: self.webUrl)
    }
    
    
    var body: some View {
        self.webview
            .navigationTitle("WebView 💻")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            self.webview.goBack()
                                  }){
                                      Image(systemName: "chevron.backward")
                                  }
                        
                        Button(action: {
                                    self.webview.goForward()
                                }){
                                    Image(systemName: "chevron.forward")
                                }
                        
                        Button(action: {
                            if UIApplication.shared.canOpenURL(self.webview.webview.url!) {
                                    UIApplication.shared.open(self.webview.webview.url!)
                                }
                            }){
                                    Image(systemName: "safari")
                                }
                    }
                    
            }
        }
    }
    
}


struct Webview_Previews: PreviewProvider {
    static var previews: some View {
        Web(webUrl: "https:www.naver.com")
    }
}
