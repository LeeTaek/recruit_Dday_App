//
//  webView.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//
import WebKit
import SwiftUI

/*
    채용 공고 링크를 보기 위한 WebView
    bug : redirect 되는 몇몇 웹이 안뜸. 때문에 해당 주소를 정확하게 입력해야함.
    ex) https://www.google.com/ 은 뜨지만 google.com은 안뜬다.
 */

struct Webview: UIViewRepresentable {
   
    var urlToLoad: String                       // url 을 저장할 변수.
    let webview = WKWebView()                   // webview 변수

    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        let encodedStr = urlToLoad.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!              // 한글 url 핸들링할 수 있도록 인코딩

        guard let url = URL(string: encodedStr) else {                               // url 언래핑
            return WKWebView()
        }

        webview.load(URLRequest(url: url))                          // 웹뷰를 로드한다.

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


struct Web: View {                      // 네비게이션에서 webView를 그리기 위한 view
    let webUrl: String
    let webview: Webview
    
    init(webUrl: String) {              // 입력받은 url로 초기화
        self.webUrl = webUrl
        self.webview = Webview(urlToLoad: self.webUrl)
    }
    
    
    var body: some View {
        self.webview
            .navigationTitle("WebView 💻")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {                            // 뒤로 가기 버튼
                            self.webview.goBack()
                                  }){
                                      Image(systemName: "chevron.backward")
                                  }
                        
                        Button(action: {                           // 앞으로 가기 버튼
                                    self.webview.goForward()
                                }){
                                    Image(systemName: "chevron.forward")
                                }
                        
                        Button(action: {                           // Safari에서 웹 보기 버튼
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
