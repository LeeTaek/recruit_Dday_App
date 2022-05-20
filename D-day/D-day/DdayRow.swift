//
//  DdayRow.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

/*
    RealmDB의 RecruitViewModel의 값을 그려주기 위한 View
    남은 채용 마감 D-day에 따라 배경 색을 다르게 그려준다.
    Apply Text를 누르면 Apply값을 true로 바꾼다.
 */

struct DdayRow: View {
    @ObservedRealmObject var recruit: RecruitViewModel       // Recruit ViewModel

    var body: some View {
        HStack {
            VStack{
                Text("\(recruit.name)")                  // 기업 이름

                    .foregroundColor(.textFiledColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, alignment: .leading)
                    .padding(.top, 25)
                
                Spacer()
                
                HStack{                                 // 마감 날짜와 요일
                    Text("\(recruit.date!)")
                    
                    Text("\(recruit.day!)")
                }
                .foregroundColor(.textFiledColor)
                .frame(width: 200 ,alignment: .leading)
                .padding(.bottom, 25)

            }.padding(.leading, 20)
            
            Spacer()
            
            VStack {
                Text("D - \(recruit.Dday!)🔥")          // D-day
                    .foregroundColor(.textFiledColor)
                    .fontWeight(.medium)
                    .frame(width: 100, alignment: .trailing)
                    .padding(.top, 25)

                Spacer()
            
                apply                       // 지원 버튼
                

            }.padding(.trailing, 20)
            
        }
        .background(self.color)
            .cornerRadius(10)
    }
    
    
    //MARK: - D-day에 따른 배경 색, 남은 D-day에 따라 배경의 색을 바꾸어 표현해준다. 
    var color: Color {
        switch recruit.getRecruit().countDday {
        case 0 :
            return .day0
            
        case 1 :
            return .day1
            
        case 2 :
            return .day2
            
        default :
            return .day
        }
    }
    
    
    
    //MARK: -  Apply 버튼
    var apply: some View {
        Text("Apply : \(recruit.apply.description)")
             .foregroundColor(.textFiledColor)
             .frame(width: 100, alignment: .trailing)
             .padding(.bottom, 25)
             .onTapGesture {
                 recruit.toggleApply()
         }
    }
    
    
}

//
//struct DdayRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DdayRow(recruit: RecruitViewModel(), recuritInfo: Recruit(), applyMessage: false)
//    }
//}
