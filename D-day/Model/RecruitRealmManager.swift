//
//  RecruitRealmManager.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import Foundation
import RealmSwift

class RecruitRealmManager: Object, ObjectKeyIdentifiable {
    @Persisted var date: String
    @Persisted var name: String
    @Persisted var day: String
    @Persisted (primaryKey: true) var link: String
    @Persisted var Dday: Int
    @Persisted var apply: Bool = false
    
    
    convenience init(recruit: Recruit) {
        self.init()
        self.date = recruit.date
        self.name = recruit.name
        self.day = recruit.day
        self.link = recruit.link
        self.Dday = recruit.countDday
    }
    
    
    // 추가
    func addSchedule(recruit: Recruit) {
        print("경로 : \(Realm.Configuration.defaultConfiguration.fileURL!)")

        let realm = try! Realm()
        
        let recruitInfo = RecruitRealmManager(recruit: recruit)
        
        try! realm.write{
            realm.add(recruitInfo)
        }
    }
    
    
    // 삭제
    func removeSchedule(recruit: Recruit) {
        let realm = try! Realm()
        
        let remove = realm.object(ofType: RecruitRealmManager.self, forPrimaryKey: recruit.link)
        
        
        try! realm.write({
            realm.delete(remove!)
        })
    }
    
    
    func getRecruit() -> Recruit {
        Recruit(name: self.name, date: self.date, link: self.link, day: self.day, Dday: self.Dday)
    }
    
    
}

