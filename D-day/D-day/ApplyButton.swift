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
            .foregroundColor(.background.opacity(20))
            .overlay(innerCircle)
    }
    
    
    var innerCircle: some View {
        GeometryReader {
            Circle()
                .frame(width: $0.size.width * 0.9, height: $0.size.height * 0.9)
                .foregroundColor(.white)
            
        }
    }
}

struct ApplyButton_Previews: PreviewProvider {
    static var previews: some View {
        ApplyButton()
    }
}
