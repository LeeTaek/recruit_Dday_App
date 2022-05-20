//
//  removedRow.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//


import SwiftUI
import RealmSwift

/*
    RealmDB의 RemoedViewModel의 값을 그려주기 위한 View
    남은 채용 마감 D-day에 따라 배경 색을 다르게 그려준다.
 */

struct removeRow: View {
    @ObservedRealmObject var recruit: RemovedViewModel

    var body: some View {
        HStack {
            VStack{
                Text("\(recruit.getRecruit().name)")
                    .foregroundColor(.textFiledColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, alignment: .leading)
                    .padding(.top, 25)
                
                Spacer()
                
                HStack{
                    Text("\(recruit.getRecruit().date!)")
                    
                    Text("\(recruit.getRecruit().day!)")
                }                    .foregroundColor(.textFiledColor)
                .frame(width: 200 ,alignment: .leading)
                .padding(.bottom, 25)

            }.padding(.leading, 20)
            
            Spacer()
            
            VStack {
                Text("D - \(recruit.getRecruit().countDday)🔥")
                    .foregroundColor(.textFiledColor)
                    .fontWeight(.medium)
                    .frame(width: 100, alignment: .trailing)
                    .padding(.top, 25)

                Spacer()
            
                Text("삭제 - \(printDate(recruit.removedDay))")
                    .foregroundColor(.textFiledColor)
                    .fontWeight(.medium)
                    .frame(width: 130, alignment: .trailing)
                    .padding(.bottom, 25)

                

            }.padding(.trailing, 20)
            
        }
        .background(self.color)
            .cornerRadius(10)
    }
    
    
    
    //MARK: - D-day에 따른 배경 색
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
    
    
    //MARK: - 날짜 변환
    func printDate(_ date: Date ) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM월 dd일"
        
        return format.string(from: date)
    }
    
    
}


//struct removedRow_Previews: PreviewProvider {
//    static var previews: some View {
//        removedRow()
//    }
//}
