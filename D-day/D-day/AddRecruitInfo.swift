//
//  AddRecruitInfo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct AddRecruitInfo: View {
    
    @State var name: String = ""
    @State var dday: Date = Date()
    @State var link: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                inputName
                
                inputDate
                
                inputLink
                
                addButton
                
                
            }
            .navigationBarTitle("Add memo📌", displayMode: .inline)
        }
    }
    
    // 기업 이름
    var inputName: some View {
        Section {
            HStack {
                TextField("Enter a company name.", text: $name)
                
                
                if self.name.count > 0 {
                    Button(action: { self.name = "" }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
        } header: {
            Text("NAME✏️")
        }
    }
    
    
    // 날짜
    var inputDate: some View {
        Section {
            DatePicker(selection: $dday, in: Date()..., displayedComponents: .date) {
                Text("enter a deadline.")
                    .foregroundColor(.gray)
            }.datePickerStyle(GraphicalDatePickerStyle())
                .colorMultiply(.brown)
        } header: {
            Text("Date📆")
        }
    }
    
    
    // 채용 링크
    var inputLink: some View {
        Section {
            HStack {
                TextField("Enter a link.", text: $link)
                
                if self.link.count > 0 {
                    Button(action: { self.link = "" }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
        } header: {
            Text("LINK💻")
        }
    }
    
    // 추가 버튼
    var addButton: some View {
        Button(action: {}) {
            Text("Add recruit Info")
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .frame(width: 350)
        }
        
    }

    
}

struct AddRecruitInfo_Previews: PreviewProvider {
    static var previews: some View {
        AddRecruitInfo()
    }
}

