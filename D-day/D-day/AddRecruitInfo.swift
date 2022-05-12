//
//  AddRecruitInfo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct AddRecruitInfo: View {
    
    @Binding var goToDday: Bool 
    
    @State var name: String = ""
    @State var dday: Date = Date()
    @State var link: String = ""
    var updateInfo = RecruitRealmManager()
    
//    init() {
//        UITableView.appearance().backgroundColor = .clear
//    }
    
    var body: some View {
    
        Form {
            inputName
            
            inputDate
            
            inputLink
            
            addButton
        }
            .navigationTitle("Add memo📌")
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // 기업 이름
    var inputName: some View {
        Section {
            HStack {
                TextField("Enter a company name.", text: $name)
                    .foregroundColor(.textFiledColor)
                
                
                if self.name.count > 0 {
                    Button(action: { self.name = "" }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
        } header: {
            Text("NAME✏️")
                .foregroundColor(.textFiledColor)

        }
    }
    
    
    
    // 날짜
    var inputDate: some View {
        Section {
            DatePicker(selection: $dday, in: Date()...) {
                Text("enter a deadline.")
                    .foregroundColor(.gray)
            }.datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(.navigationItem)
        } header: {
            Text("Date📆")
                .foregroundColor(.textFiledColor)

        }
    }
    
    
    
    // 채용 링크
    var inputLink: some View {
        Section {
            HStack {
                TextField("Enter a link.", text: $link)
                    .foregroundColor(.textFiledColor)

                if self.link.count > 0 {
                    Button(action: { self.link = "" }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
        } header: {
            Text("LINK💻")
                .foregroundColor(.textFiledColor)

        }
    }
    
    // 추가 버튼
    var addButton: some View {
        Button(action: {
            self.updateInfo.addSchedule(recruit: recruitInfo)
            goToDday = false
        }) {
            Text("Add recruit Info")
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .frame(width: 350)
        }
    }

    
    
    var recruitInfo: Recruit {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd kk시" // Date 포맷 타입 지정
        let date = dateFormatter.string(from: self.dday)
        
        dateFormatter.dateFormat = "E요일"
        let day = dateFormatter.string(from: self.dday)
        let countDay = Int(self.dday.timeIntervalSinceNow / 86400)
        
        return Recruit(name: self.name, date: date, link: self.link, day: day, Dday: countDay)
    }
  
    
}

//struct AddRecruitInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecruitInfo(goToDday: $goToAddMemo)
//    }
//}

