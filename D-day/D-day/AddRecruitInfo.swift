//
//  AddRecruitInfo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

/*
    RecruitViewModel에 Update하기 위한 View
    기업 이름과 마감 날짜, 채용 Link를 가지고 Recruit Model를 만들어 RecruitViewModel에 추가한다.
 */


struct AddRecruitInfo: View {
    @Binding var goToDday: Bool                     // Add버튼 누르면 Dday()로 가기위한 바인딩값

    @State var name: String = ""                    // TextFiled를 통해 기업 이름을 받을 변수
    @State var dday: Date = Date()                  // DatePicker를 통해 마감 날자를 받을 변수
    @State var link: String = ""                    // TextFiled를 통해 채용 링크를 받을 변수
    var updateInfo = RecruitViewModel()             // Recruit를 저장할 ViewModel

    
    
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
    
    
    //MARK: - 기업 이름 입력란
    var inputName: some View {
        Section {
            HStack {
                TextField("Enter a company name.", text: $name)
                    .disableAutocorrection(true)                 // 맞춤법 자동 수정 기능 끔.
                    .foregroundColor(.textFiledColor)
                
                
                if self.name.count > 0 {                        // 입력된 글자를 지우기 위한 X버튼
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
    
    
    
    //MARK: - 마감 날짜 입력란
    var inputDate: some View {
        Section {
            DatePicker(selection: $dday, in: Date()...) {           // 이미 지난 날짜는 입력받지 않음.
                Text("enter a deadline.")
                    .foregroundColor(.gray)
            }.datePickerStyle(GraphicalDatePickerStyle())           // 그래픽 피커 스타일, iOS 14부터 지원
                .accentColor(.navigationItem)
        } header: {
            Text("Date📆")
                .foregroundColor(.textFiledColor)

        }
    }
    
    
    
    //MARK: - 채용 링크 입력란
    var inputLink: some View {
        Section {
            HStack {
                TextField("Enter a link.", text: $link)
                    .disableAutocorrection(true)                 // 맞춤법 자동 수정 기능 끔.
                    .foregroundColor(.textFiledColor)

                if self.link.count > 0 {                            // 입력된 글자를 지우기 위한 X버튼
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
    
    
    //MARK: - Add버튼
    var addButton: some View {
        Button(action: {
            self.updateInfo.addSchedule(recruit: recruitInfo)
            goToDday = false                                    // 버튼을 누르면 goToDday 변수를 fasle로 넘겨 DdayView로 이동.
        }) {
            Text("Add recruit Info")
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .frame(width: 350)
        }
    }

    
    
    //MARK: - 받은 정보로 Recruit 타입으로 변환
    var recruitInfo: Recruit {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd kk시"                  // Date 포맷 타입 지정
        let date = dateFormatter.string(from: self.dday)
        
        dateFormatter.dateFormat = "E"                          // 요일
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

