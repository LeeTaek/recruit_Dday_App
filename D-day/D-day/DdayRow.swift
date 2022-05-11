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
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, alignment: .leading)
                
                Spacer()
                
                HStack{
                    Text("\(recuritInfo.date)")
                    Text("\(recuritInfo.day)")
                }.frame(width: 200 ,alignment: .leading)
                
                
            }.padding()
            
            Spacer()
            
            VStack {
                Text("D - \(recuritInfo.countDday)🔥")
                    .fontWeight(.medium)
                    .frame(width: 100, alignment: .trailing)
                
                Spacer()
                
                Text("apply 버튼 자리")
                    .frame(width: 120, alignment: .trailing)
            }.padding()
            
        }.frame(height: 100)
            .background(self.color)
            .cornerRadius(10)
            .padding()
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
