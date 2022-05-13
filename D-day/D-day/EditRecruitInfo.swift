//
//  EditRecruitInfo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/13.
//


import SwiftUI

struct EditRecruitInfo: View {
    
    @Binding var goToDday: Bool
    @State var rec: Recruit
    @State var name: String = ""
    @State var dday: Date = Date()
    
    var updateInfo = RecruitRealmManager()

    
  
    
    
    var body: some View {
        Form {
           Text("Link는 수정할 수 없습니다 😢")
                .font(.footnote)
                .foregroundColor(.textFiledColor)
                .background(.background)
            
            inputName
            
            inputDate
                        
            editButton
        }
            .navigationTitle("Eidt memo📌")
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    //MARK: - 기업 이름 입력란
    var inputName: some View {
        Section {
            HStack {
                TextField("Enter a company name.", text: $name)
                    .disableAutocorrection(true)
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
    
    
    
    //MARK: - 날짜 입력란
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
    
    
    

    //MARK: - Edit 버튼
    var editButton: some View {
        Button(action: {
            self.updateInfo.eduitSchedule(origin: rec, recruit: recruitInfo)
            goToDday = false
        }) {
            Text("Edit recruit Info")
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .frame(width: 350)
        }
    }

    
    
    //MARK: - 받은 정보로 Recrui 타입으로 변환
    var recruitInfo: Recruit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd kk시" // Date 포맷 타입 지정
        let date = dateFormatter.string(from: self.dday)
        
        dateFormatter.dateFormat = "E요일"
        let day = dateFormatter.string(from: self.dday)
        let countDay = Int(self.dday.timeIntervalSinceNow / 86400)
        
        return Recruit(name: self.name, date: date, link: rec.link, day: day, Dday: countDay)
    }
  
    
}
