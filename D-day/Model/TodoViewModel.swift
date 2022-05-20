//
//  TodoViewModel.swift
//  D-day
//
//  Created by 이택성 on 2022/05/16.
//

import Foundation
import RealmSwift

/*
    Todo를 관리하기 위한 ViewModel
 */


class TodoViewModel: Object, ObjectKeyIdentifiable {
    @Persisted var date: Date
    @Persisted (primaryKey: true) var name: String
    @Persisted var check: Bool = false
    @Persisted var variety: String
    
    
    convenience init(todo: Todo) {
        self.init()
        
        self.date = todo.date
        self.name = todo.name
        self.check = false
        self.variety = todo.variety
    }
    
    
    //MARK: - 추가
    func addTodo(todo: Todo) {
        print("경로 : \(Realm.Configuration.defaultConfiguration.fileURL!)")

        let realm = try! Realm()
        let todoInfo = TodoViewModel(todo: todo)
        
        do {
            try realm.write{
                realm.add(todoInfo)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    
    }
    
    
    //MARK: - 삭제
    func removeTodo(todo: Todo) {
        let realm = try! Realm()
        
        let deleteTodo = realm.object(ofType: TodoViewModel.self, forPrimaryKey: todo.name)!
        
        try! realm.write {
            realm.delete(deleteTodo)
        }
    }
   

    
    //MARK: - 완료
    func toggleTodo() {
        let realm = try! Realm()
        
        let toggleTodo = realm.object(ofType: TodoViewModel.self, forPrimaryKey: self.name)!
        
        try! realm.write{
            toggleTodo.check.toggle()
        }
    }
    
    
    
    //MARK: - 다음 날로 연기
    func delayTodo(todo: Todo) {
        let realm = try! Realm()
        
        let delayTodo = realm.object(ofType: TodoViewModel.self, forPrimaryKey: todo.name)!
        
        try! realm.write {
            delayTodo.date = delayTodo.date.addingTimeInterval(86400)
        }
    }
    

}

