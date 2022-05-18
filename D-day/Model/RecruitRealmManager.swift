//
//  RecruitRealmManager.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import Foundation
import RealmSwift

class RecruitRealmManager: Object, ObjectKeyIdentifiable {
    @Persisted var date: String?
    @Persisted var name: String
    @Persisted var day: String?
    @Persisted (primaryKey: true) var link: String
    @Persisted var Dday: Int?
    @Persisted var apply: Bool = false
    

    convenience init(recruit: Recruit) {
        self.init()

        self.date = recruit.date
        self.name = recruit.name
        self.day = recruit.day
        self.link = recruit.link
        self.Dday = recruit.countDday
    }
    
    
    //MARK: - 추가
    func addSchedule(recruit: Recruit) {
        print("경로 : \(Realm.Configuration.defaultConfiguration.fileURL!)")

        let realm = try! Realm()
        
        let recruitInfo = RecruitRealmManager(recruit: recruit)
        
        do {
            try realm.write{
                realm.add(recruitInfo)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
       
    
    }
    
    
    
    //MARK: - 삭제
    func removeSchedule(recruit: Recruit) {
        let realm = try! Realm()
        let removeModel = RemovedViewModel()
        let remove = realm.object(ofType: RecruitRealmManager.self, forPrimaryKey: recruit.link)!
        
        removeModel.addSchedule(recruit: remove.getRecruit())

        
        try! realm.write({
            realm.delete(remove)
                    })
        
        
    }
    
    
    //MARK: - 수정
    func eduitSchedule(origin: Recruit, recruit: Recruit) {
        let realm = try! Realm()
        
        let originData = realm.object(ofType: RecruitRealmManager.self, forPrimaryKey: origin.link)!
        
        try! realm.write{
            originData.name = recruit.name
            originData.Dday = recruit.countDday
            originData.date = recruit.date
            originData.day = recruit.day
        }
        
        
    }
    
    
    //MARK: - 현재값 반환
    func getRecruit() -> Recruit {
        Recruit(name: self.name, date: self.date ?? "지금시간", link: self.link, day: self.day ?? "불금", Dday: self.Dday ?? 800)
    }
    
    
    //MARK: - 지원버튼
    func toggleApply() {
        let realm = try! Realm()
        
        let update = realm.object(ofType: RecruitRealmManager.self, forPrimaryKey: self.link)!
    
        try! realm.write{
            update.apply.toggle()
        }
        
    }
    
    //MARK: - 채용기간 지난건 제거
    func overDeadline() {
        let realm = try! Realm()
        
        let over = realm.objects(RecruitRealmManager.self).filter { $0.Dday! < 0 }
        
        over.forEach {
            print("\($0.getRecruit().name)")
            removeSchedule(recruit: $0.getRecruit())
        }
    }
    
    
    
}

