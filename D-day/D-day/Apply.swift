//
//  Apply.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//

import SwiftUI
import RealmSwift

/*
    지원한 공고들을 보기위한 View
    RecruitViewModel에서 apply가 true 인 값들만 보여준다.
 */


struct Apply: View {
    @ObservedResults(RecruitViewModel.self) var recruitInfo        // 관찰하고 있는 Realm의 RecruiViwModel
    
    var body: some View {
        recruitList
    }
    
    
    //MARK: - 지원한 채용 공고 리스트
    var recruitList: some View {
        List(recruitInfo.sorted(byKeyPath: "Dday").filter{ $0.apply == true }) { recruit in             // apply가 true인 공고를 마감순으로 정렬하여 올려줌.
            HStack {
                DdayRow(recruit: recruit)
                
                // 각 리스트에서 ContextView를 통해 Edit뷰로 이동하기 위한 NavigationLink, goToEdit 변수를 통해 NavigationLink를 띄운다.
                NavigationLink(destination: Webview(urlToLoad: recruit.getRecruit().link )) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            }
            .animation(.easeInOut, value: recruitInfo.count)
            .frame(height: 120)
            .contextMenu {      // 컨텍스트 메뉴
                HStack{
                    Button(action: {
                        recruit.removeSchedule(recruit: recruit.getRecruit())
                    }) {
                        Text("Remove Memo 🗑")
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationTitle("Apply✔️")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct Apply_Previews: PreviewProvider {
    static var previews: some View {
        Apply()
    }
}
