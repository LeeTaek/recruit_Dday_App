//
//  appliedViewModel.swift
//  D-day
//
//  Created by 이택성 on 2022/05/12.
//

import Foundation
import RealmSwift

class RemovedViewModel: Object, ObjectKeyIdentifiable {
    @Persisted var date: String?
    @Persisted var name: String
    @Persisted var day: String?
    @Persisted (primaryKey: true) var link: String
    @Persisted var Dday: Int?
    @Persisted var apply: Bool = false
    @Persisted var removedDay: Date = Date.now
    
    
    
    convenience init(recruit: Recruit) {
        self.init()
        self.overDeadline()

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
        let recruitInfo = RemovedViewModel(recruit: recruit)
        
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
        
        let remove = realm.object(ofType: RemovedViewModel.self, forPrimaryKey: recruit.link)!
 
        try! realm.write({
            realm.delete(remove)
        })
    }
    
    
    //MARK: - 현재값 반환
    func getRecruit() -> Recruit {
        Recruit(name: self.name, date: self.date ?? "지금시간", link: self.link, day: self.day ?? "불금", Dday: self.Dday ?? 800)
    }
    
    
    //MARK: - 복구
    func recorvery(recruit: Recruit ) {
        let realm = try! Realm()
        let rec = RecruitRealmManager()
        let recover = realm.object(ofType: RemovedViewModel.self, forPrimaryKey: recruit.link)!
        rec.addSchedule(recruit: recover.getRecruit())

        try! realm.write({
            realm.delete(recover)
        })
    }
    
    
    
    //MARK: - 지워진지 3일 이상 된것들 제거
    func overDeadline() {
        let realm = try! Realm()
        
        let over = realm.objects(RemovedViewModel.self).filter { $0.removedDay.timeIntervalSince(Date.now) > 259200 }
        
        over.forEach {
            removeSchedule(recruit: $0.getRecruit())
        }
    }
    
}

