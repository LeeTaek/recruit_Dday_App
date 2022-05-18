//
//  TodoList.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

struct TodoList: View {
    @ObservedResults(TodoViewModel.self) var todoInfo
    @State var goToAddTodo = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear           // link로 연결될 뷰의 색깔도 변경하기 위해 배경색 claer
        
    }
    
    
    var body: some View {
        NavigationView {
            TodoList
                .setTabBarVisibility(isHidden: false)
                .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddTodo(goToDoList: $goToAddTodo)
                                .setTabBarVisibility(isHidden: true), isActive: $goToAddTodo) {
                                Image(systemName: "plus")
                                    .foregroundColor(.navigationItem)
                            }
                            
                        }
                    }
        }
        .navigationViewStyle(.stack)
    }
    
    
    
    // TodoList View
    var TodoList: some View {
        List(todoInfo.sorted(byKeyPath: "variety")) { todo in
            HStack {
                // edit 뷰
                
                TodoRow(todo: todo)
                
                
            }
            
        }
        .background(Color.background)           // 배경색 설정
        .navigationTitle("TodoList🔖")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    
    //
    
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
