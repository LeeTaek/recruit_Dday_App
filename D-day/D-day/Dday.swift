//
//  Dday.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct Dday: View {
    var body: some View {
        NavigationView {
            VStack {
                DdayRow(recuritInfo: Recruit())
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddRecruitInfo()) {
                        Image(systemName: "plus")
                    }
                    
                }
            }.navigationBarTitle("Recruit Info❗️", displayMode: .inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dday()
    }
}
