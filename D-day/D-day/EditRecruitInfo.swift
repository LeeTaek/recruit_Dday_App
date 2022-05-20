//
//  EditRecruitInfo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/13.
//

import SwiftUI

/*
    RealmDB의 RecruitViewModel의 값을 수정하기 위한 View
    Link를 Key값으로 사용하여 link값은 변경 못한다.
 */


struct EditRecruitInfo: View {
    
    @Binding var goToDday: Bool                 // Edit 버튼 누르면 Dday()로 가기위한 바인딩값
    @State var rec: Recruit                     // 수정할 채용 공고의 Recruit모델
    @State var name: String = ""                // TextFiled를 수정할 기업 이름을 받을 변수
    @State var dday: Date = Date()              // DatePicker를 통해 수정할 채용 마감 날짜를 받을 변수.
    
    var updateInfo = RecruitViewModel()         // 수정할 내용을 저장할 ViewModel
    
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
    
    
    
    //MARK: - 기업 이름 입력, 초기값으로 수정할 기업 이름이 들어옴.
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
    
    
    
    //MARK: - 날짜 입력란, 초기값으로 수정할 채용 마감 날짜가 들어옴.
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
