//
//  DdayRow.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct DdayRow: View {
    var recuritInfo = Recruit()
    
    var body: some View {
        HStack {
            VStack{
                Text("\(recuritInfo.name)")
                    .foregroundColor(.textFiledColor)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, alignment: .leading)
                    .padding(.top, 25)
                
                Spacer()
                
                HStack{
                    Text("\(recuritInfo.date)")
                    
                    Text("\(recuritInfo.day)")
                }                    .foregroundColor(.textFiledColor)
                .frame(width: 200 ,alignment: .leading)
                .padding(.bottom, 25)

            }.padding(.leading, 20)
            
            Spacer()
            
            VStack {
                Text("D - \(recuritInfo.countDday)🔥")
                    .foregroundColor(.textFiledColor)
                    .fontWeight(.medium)
                    .frame(width: 100, alignment: .trailing)
                    .padding(.top, 25)

                Spacer()
                
                Text("apply")
                    .foregroundColor(.textFiledColor)
                    .frame(width: 100, alignment: .trailing)
                    .padding(.bottom, 25)

            }.padding(.trailing, 20)
            
        }.background(self.color)
            .cornerRadius(10)
    }
    
    
    
    var color: Color {
        switch recuritInfo.countDday {
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

}

struct DdayRow_Previews: PreviewProvider {
    static var previews: some View {
        DdayRow(recuritInfo: Recruit())
    }
}
