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
    let importance: Int
    
    init() {
        self.date = Date.now
        self.name = "블로그 정리"
        self.check = false
        self.importance = 2
    }
    
    init(name: String, importance: Int) {
        self.date = Date.now
        self.name = name
        self.check = false
        self.importance = importance
    }
    
}
