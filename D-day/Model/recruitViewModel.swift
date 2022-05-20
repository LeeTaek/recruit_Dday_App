//
//  RecruitViewModel.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import Foundation
import RealmSwift

/*
    채용 공고 관리를 위한 ViewModel
    입력한 채용 공고와 지원한 채용 공고를 다룸.
    이미 지나거나 지운 공고는 RemovedViewModel 넘김.
 */

class RecruitViewModel: Object, ObjectKeyIdentifiable {
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
        let recruitInfo = RecruitViewModel(recruit: recruit)
        
        try! realm.write{
            realm.add(recruitInfo)
        }
    }
    
    
    
    //MARK: - 삭제: RemovedViewModel로 옮김
    func removeSchedule(recruit: Recruit) {
        let realm = try! Realm()
        let removeModel = RemovedViewModel()
        let remove = realm.object(ofType: RecruitViewModel.self, forPrimaryKey: recruit.link)!
        
        removeModel.addSchedule(recruit: remove.getRecruit())

        try! realm.write{
            realm.delete(remove)
        }
    }
    
    
    //MARK: - 수정
    func eduitSchedule(origin: Recruit, recruit: Recruit) {
        let realm = try! Realm()
        
        let originData = realm.object(ofType: RecruitViewModel.self, forPrimaryKey: origin.link)!
        
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
        let update = realm.object(ofType: RecruitViewModel.self, forPrimaryKey: self.link)!
    
        try! realm.write{
            update.apply.toggle()
        }
    }
    
    
    
    //MARK: - 채용기간 지난건 제거
    func overDeadline() {
        let realm = try! Realm()
        
        let over = realm.objects(RecruitViewModel.self).filter { $0.Dday! < 0 }
        
        over.forEach {
            print("\($0.getRecruit().name)")
            removeSchedule(recruit: $0.getRecruit())
        }
    }
    
    
    
}

