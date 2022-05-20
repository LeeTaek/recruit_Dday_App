//
//  Dday.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

/*
    채용 공고 리스트를 보여주기 위한 메인 View
    RealmDB의 RecruitViewModel을 관찰하여 그 값을 List로 그려준다.
    여기서 AddRecruitInfo, WebView, Apply, Removed, EditRecruitInfo View로 연결 된다.
 */


struct Dday: View {
    @ObservedResults(RecruitViewModel.self) var recruitInfo         // 관찰하고 있는 Realm의 RecruitViwModel
    @State var goToEdit = false                                     // EditView에서 Eidt버튼을 누르면 Dday View를 띄우기 위한 변수
    @State var goToAddMemo = false                                  // AddView에서 Add버튼을 누르면 Dday View를 띄우기 위한 변수

    
    init() {
        UITableView.appearance().backgroundColor = .clear           // link로 연결될 뷰의 색깔도 변경하기 위해 배경색 claer
        
        // 공고가 지난 지난 애들 지우고 보여줌.
        if let firstRec = recruitInfo.first {
            firstRec.overDeadline()
        }
    
    }
    
    
    
    var body: some View {
        NavigationView {
            recruitList
                .setTabBarVisibility(isHidden: false)           //   DdayView에서는 탭바를 보여줌.
                .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            recruitToolBarItem
                        }
                    }
        }.onAppear(){
            UINavigationBar.appearance().tintColor = .init(Color.textFiledColor)
        }
        .navigationViewStyle(.stack)
        
      
    }
    
    //MARK: - 네비게이션 아이템
    var recruitToolBarItem: some View {
        HStack {
            // 지원한 채용 공고들을 확인하기 위한 뷰
            NavigationLink(destination: Apply()
                .setTabBarVisibility(isHidden: true)) {
                Image(systemName: "text.badge.plus")
                    .foregroundColor(.navigationItem)
            }
            
            // 제거하거나 채용 기간이 공고들을 확인하기 위한 뷰
            NavigationLink(destination: Removed()
                .setTabBarVisibility(isHidden: true)) {
                Image(systemName: "trash")
                    .foregroundColor(.navigationItem)
            }
            
            // 채용공고를 추가하기 위한 뷰로 이동
            NavigationLink(destination: AddRecruitInfo(goToDday: $goToAddMemo)
                .setTabBarVisibility(isHidden: true), isActive: $goToAddMemo) {
                Image(systemName: "plus")
                    .foregroundColor(.navigationItem)
            }
        }
    }
    
    
    
    //MARK: - 채용 리스트: RecruitViewModel을 관찰하여 변화가 있을 때에 이를 반영하여 View를 띄어줌
    var recruitList: some View {
        List(recruitInfo.sorted(byKeyPath: "Dday").filter{ $0.apply == false }) { recruit in        // apply가 fasle인 공고를 마감순으로 정렬하여 올려줌.
            HStack {
                DdayRow(recruit: recruit)
                
                // 각 리스트에서 ContextView를 통해 Edit뷰로 이동하기 위한 NavigationLink, goToEdit 변수를 통해 NavigationLink를 띄운다.
                NavigationLink(destination: EditRecruitInfo(goToDday: $goToEdit, rec: recruit.getRecruit(), name: recruit.getRecruit().name)
                    .setTabBarVisibility(isHidden: true), isActive: $goToEdit){
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            }
            .background(            // 각 리스트를 터치할 때에 WebView를 띄우기 위한 NavigationLink
                                    // ContextView에서 다른 View로 이동하기 위해 webView를 background로 이동.
                NavigationLink(destination: Web(webUrl: recruit.getRecruit().link)
                    .background(Color.background)) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            )
            .contextMenu {          // 컨텍스트 메뉴
                Button(action: {                // goToEdit변수를 true로 바꾼다. EditView에서 이를 받아 뷰를 띄운다.
                    self.goToEdit = true
                    }) {
                        Text("Edit Recruit Memo 🔖")
                    }
               
                Button(action: {                // 해당 리스트를 RecruitViewModel에서 삭제
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

