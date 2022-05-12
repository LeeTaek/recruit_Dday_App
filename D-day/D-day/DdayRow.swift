//
//  DdayRow.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

struct DdayRow: View {
    @ObservedRealmObject var recruit : RecruitRealmManager

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
            
                apply
                

            }.padding(.trailing, 20)
            
        }.background(self.color)
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
    
    
    
    
    var apply: some View {
        
        Text("Apply : \(recruit.apply.description)")
             .foregroundColor(.textFiledColor)
             .frame(width: 100, alignment: .trailing)
             .padding(.bottom, 25)
             .onTapGesture {
                 recruit.toggleApply(site: recruit.getRecruit().link)
                 
             }
        
    }
    
    
    

}

//struct DdayRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DdayRow(recruit: <#RecruitRealmManager#>, recuritInfo: Recruit(), applyMessage: false)
//    }
//}
