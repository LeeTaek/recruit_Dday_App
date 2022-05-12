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
    @State var goToAddMemo = false

    var body: some View {
        NavigationView {
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
            }
            .foregroundColor(Color.tabColor)
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(destination: Apply()) {
                                Image(systemName: "text.badge.plus")
                                    .foregroundColor(.navigationItem)
                            }
                            
                            NavigationLink(destination: Removed()) {
                                Image(systemName: "trash")
                                    .foregroundColor(.navigationItem)
                            }
                            
                            NavigationLink(destination: AddRecruitInfo(goToDday: $goToAddMemo), isActive: $goToAddMemo) {
                                Image(systemName: "plus")
                                    .foregroundColor(.navigationItem)
                            }
                        }
                        
                       
                    }
                
                
                
                
                }
            }
        .navigationViewStyle(.stack)

        
    }
    
    

    
  
}

struct mainTabView_Previews: PreviewProvider {
    static var previews: some View {
        mainTabView()
    }
}
