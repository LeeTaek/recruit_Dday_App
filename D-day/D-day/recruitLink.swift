//
//  recruitLink.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct recruitLink: View {
    
    var link: String
    
    var body: some View {
        Webview(urlToLoad: link)
            .navigationTitle("WebSite 📃")
    }
}

struct recruitLink_Previews: PreviewProvider {
    static var previews: some View {
        recruitLink(link: "https://www.instagram.com/lee_taek/")
    }
}
