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
    @State var goToEdit = false
    @State var goToAddMemo = false

    
    init() {
        UITableView.appearance().backgroundColor = .clear           // link로 연결될 뷰의 색깔도 변경하기 위해 배경색 claer
        
        // 날짜 지난 애들 지우고 보여줌.
        if let firstRec = recruitInfo.first {
            firstRec.overDeadline()
        }
    
    }
    
    
    
    var body: some View {
        NavigationView {
            recruitList
                .setTabBarVisibility(isHidden: false)
                .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            recruitToolBarItem
            
                        }
                    }
        }
      
    }
    
    
    var recruitToolBarItem: some View {
        HStack {
            NavigationLink(destination: Apply()
                .setTabBarVisibility(isHidden: true)) {
                Image(systemName: "text.badge.plus")
                    .foregroundColor(.navigationItem)
            }
            
            NavigationLink(destination: Removed()
                .setTabBarVisibility(isHidden: true)) {
                Image(systemName: "trash")
                    .foregroundColor(.navigationItem)
            }
            
            NavigationLink(destination: AddRecruitInfo(goToDday: $goToAddMemo)
                .setTabBarVisibility(isHidden: true), isActive: $goToAddMemo) {
                Image(systemName: "plus")
                    .foregroundColor(.navigationItem)
            }
        }
    }
    
    
    //MARK: - 메모 리스트
    var recruitList: some View {
        List(recruitInfo.sorted(byKeyPath: "Dday").filter{ $0.apply == false }) { recruit in
            HStack {
                DdayRow(recruit: recruit)
                
                // edit 뷰
                NavigationLink(destination: EditRecruitInfo(goToDday: $goToEdit, rec: recruit.getRecruit(), name: recruit.getRecruit().name), isActive: $goToEdit){
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
                
            }
            .background(
                
                // 웹뷰
                
                NavigationLink(destination: Web(webUrl: recruit.getRecruit().link)
                    .background(Color.background)

                ) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
                
  
            )
            .contextMenu {      // 컨텍스트 메뉴
               
                Button(action: {
                    self.goToEdit = true
                    }) {
                        Text("Edit Recruit Memo ")
                    }
               
                Button(action: {
                        recruit.removeSchedule(recruit: recruit.getRecruit())
                    }) {
                        Text("Remove Memo 🗑")
                    }
            }
            .listRowBackground(Color.clear)
            .animation(.easeInOut, value: recruitInfo.count)


        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationTitle("Recruit❗️")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    
    
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dday()
    }
}
