//
//  removed.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct Removed: View {
    @ObservedResults(RemovedViewModel.self) var recruitInfo
    
    var body: some View {
        recruitList
    }
    
    
    //MARK: - 메모 리스트
    var recruitList: some View {
        List(recruitInfo) { recruit in
            HStack {
                removeRow(recruit: recruit)
                
                NavigationLink(destination: recruitLink(link: recruit.getRecruit().link )) {
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
        .navigationTitle("Apply✔️")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct Removed_Previews: PreviewProvider {
    static var previews: some View {
        Removed()
    }
}
