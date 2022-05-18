//
//  ColorExtension.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

extension Color {
    
    static let day0 = Color(hex: "FD5D5D")
    static let day1 = Color(hex: "FF8080")
    static let day2 = Color(hex: "FFF7BC")
    static let day = Color(hex: "C0EDA6")
    static let tabColor = Color(hex: "FEFBE7")
    static let navigationItem = Color(hex: "A0BCC2")
    static let background = Color(hex: "F9EBC8")
    static let textFiledColor = Color(hex: "22577E")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)      //문자열 파서 역할하는 클래스
        _ = scanner.scanString("#")             // #문자 제거
            
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)              // 문자열을 Int64타입으로 변환해 rgb 변수에 저장, 변환이 안되면 0으로 반환
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0          // 좌측 문자열 2개 추출
        let g = Double((rgb >> 8) & 0xFF) / 255.0          // 중간 문자열 2개 추출
        let b = Double((rgb >> 0) & 0xFF) / 255.0          // 좌측 문자열 2개 추출
        
        self.init(red: r, green: g, blue: b)
    }
        
}
