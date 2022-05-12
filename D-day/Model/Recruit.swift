//
//  recruit.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//
import Foundation

struct Recruit {
    let date: String?
    let day: String?
    let name: String
    let link: String
    let countDday: Int
    let apply: Bool
    
    init() {
        self.date = "Date.now"
        self.day = "수요일"
        self.name = "주식회사 택꽁"
        self.link = "https://www.instagram.com/lee_taek/"
        self.countDday = 0
        self.apply = false
    }
    
    init(name: String, date: String, link: String, day: String, Dday: Int) {

        self.date = date
        self.name = name
        self.link = link
        self.countDday = Dday
        self.apply = false
        self.day = day
    }

}


