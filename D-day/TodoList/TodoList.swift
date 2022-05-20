//
//  TodoList.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI
import RealmSwift

/*
    Todo 리스트를 보여주기 위한 메인 View
    RealmDB의 TodoViewModel을 관찰하여 그 값을 List로 그려준다.
 */

struct TodoList: View {
    @ObservedResults(TodoViewModel.self) var todoInfo               // 관찰하라 TodoViewModel
    @State var goToAddTodo = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear           // link로 연결될 뷰의 색깔도 변경하기 위해 배경색 claer
    }
    
    
    var body: some View {
        NavigationView {
            TodoList
                .setTabBarVisibility(isHidden: false)               // 해당 뷰에서 탭뷰를 보임
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
                TodoRow(todo: todo)
            }
            
        }
        .background(Color.background)           // 배경색 설정
        .navigationTitle("TodoList🔖")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
