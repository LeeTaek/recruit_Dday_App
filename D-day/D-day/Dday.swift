//
//  Dday.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

struct Dday: View {
    @ObservedResults(RecruitRealmManager.self) var recruitInfo
    
    init() {
            UITableView.appearance().backgroundColor = .clear // <-- here
    }
    
    var body: some View {
        NavigationView {
            VStack {
        
                recruitList
            }.toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddRecruitInfo()) {
                            Image(systemName: "plus")
                                .foregroundColor(.navigationItem)
                        }
                    }
                }
                .navigationTitle("Recruit❗️")
                .navigationBarTitleDisplayMode(.inline)
                
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var recruitList: some View {
        List(recruitInfo.sorted(byKeyPath: "Dday")) { recruit in
            HStack {
                DdayRow(recuritInfo: recruit.getRecruit())
                
                NavigationLink(destination: recruitLink(link: recruit.getRecruit().link)) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.background)
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dday()
    }
}
