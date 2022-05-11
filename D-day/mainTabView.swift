//
//  TabView.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct mainTabView: View {
    private enum Tabs {
        case recruit, TodoList
    }
    
    
    @State private var selectedTab: Tabs = .recruit
    
    var body: some View {
        TabView(selection: $selectedTab) {
           
            Group{
                
                Dday()
                    .tag(Tabs.recruit)
                    .tabItem {
                        Text("recruit❗️")
                    }
                
                TodoList()
                    .tag(Tabs.TodoList)
                    .tabItem {
                        Text("TodoList📍")
                    }
                
            }
           
        } .listRowBackground(Color.clear)
        .foregroundColor(Color.tabColor)
    }
    
    
  
}

struct mainTabView_Previews: PreviewProvider {
    static var previews: some View {
        mainTabView()
    }
}
