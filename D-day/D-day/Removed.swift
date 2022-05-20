//
//  removed.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//

import SwiftUI
import RealmSwift

/*
    채용 공고가 지나거나 지운 채용 공고를 보여주는 View.
    RealmDB의 RemovedViewModel을 관찰하여 그 값을 List로 그려준다.
    삭제된 시간으로부터 3일이 지나면 완전히 삭제된다. 
 */


struct Removed: View {
    @ObservedResults(RemovedViewModel.self) var recruitInfo         // 관찰하고 있는 Realm의 RemovedViwModel
    
    var body: some View {
        recruitList
    }
    
    //MARK: - 지워진 채용 리스트: RemoedViewModel을 관찰하여 변화가 있을 때에 이를 반영하여 View를 띄어줌
    var recruitList: some View {
        List(recruitInfo) { recruit in
            HStack {
                removeRow(recruit: recruit)
                
                // 해당 공고의 웹뷰를 띄움.
                NavigationLink(destination: Webview(urlToLoad: recruit.getRecruit().link )) {
                    EmptyView()
                }.frame(width: 0)
                    .opacity(0)
            }
            .contextMenu {      // 컨텍스트 메뉴
                    Button(action: {
                        recruit.recorvery(recruit: recruit.getRecruit())
                    }) {
                        Text("Recover Memo 🗳")
                    }}
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationTitle("removed 🗑")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct Removed_Previews: PreviewProvider {
    static var previews: some View {
        Removed()
    }
}
