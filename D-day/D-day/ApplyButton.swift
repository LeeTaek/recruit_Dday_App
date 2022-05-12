//
//  ApplyButton.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//

import SwiftUI

struct ApplyButton: View {
    
    
    var body: some View {
        Circle()
            .foregroundColor(.textFiledColor)
            .frame(width: 150, height: 150)
            .overlay(innerCircle)
    }
        
    var innerCircle: some View {
        GeometryReader {
            Circle()
                .foregroundColor(.background)
                .frame(width: $0.size.width * 0.9, height: $0.size.height * 0.90, alignment: .center)
                .position(x: $0.size.width/2, y: $0.size.width/2)
                .overlay(Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: $0.size.width / 2, height: $0.size.height / 2, alignment: .center))
                .foregroundColor(.textFiledColor)
        }
    }
}

struct ApplyButton_Previews: PreviewProvider {
    static var previews: some View {
        ApplyButton()
    }
}
