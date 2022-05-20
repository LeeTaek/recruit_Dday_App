//
//  Todo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/16.
//

import Foundation

struct Todo {
    let date: Date
    let name: String
    let check: Bool
    let variety: String
    
    init() {             // Preview 보기 위한 Todo 예
        self.date = Date.now
        self.name = "블로그 정리"
        self.check = false
        self.variety = "personal"
    }
    
    init(name: String, variety: String) {
        self.date = Date.now
        self.name = name
        self.check = false
        self.variety = variety
    }
    
}
