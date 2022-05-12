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
        UITableView.appearance().backgroundColor = .clear           // link로 연결될 뷰의 색깔도 변경하기 위해 배경색 claer
        
        // 날짜 지난 애들 지우고 보여줌.
        if let firstRec = recruitInfo.first {
            firstRec.overDeadline()
        }
    
    }
    
    
    var body: some View {
        recruitList
    }
    
    
    //MARK: - 메모 리스트
    var recruitList: some View {
        List(recruitInfo.sorted(byKeyPath: "Dday").filter{ $0.apply == false }) { recruit in
            HStack {
                DdayRow(recruit: recruit)

                
                NavigationLink(destination: recruitLink(link: recruit.getRecruit().link )) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            }
            .contextMenu {      // 컨텍스트 메뉴
                HStack{
                    Button(action: {
                       print("edit 기능 ")
                    }) {
                        Text("Edit recruit info 🔖")
                    }}
                
                    Button(action: {
                        recruit.removeSchedule(recruit: recruit.getRecruit())
                    }) {
                        Text("Remove Memo 🗑")
                    }}
            .listRowBackground(Color.clear)

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
