//
//  AddTodo.swift
//  D-day
//
//  Created by 이택성 on 2022/05/18.
//

import SwiftUI

struct AddTodo: View {
    //Add버튼 누르면 Dday()로 가기위한 바인딩값
    @Binding var goToDoList: Bool
    
    @State var name: String = ""
    @State var dday: Date = Date.now
    @State var variety: String = "CS공부"
    private let varietyOptions = ["CS공부", "App만들기", "취업지원", "기타"]
    
    var updateInfo = TodoViewModel()

    
    
    var body: some View {
        Form {
            inputName
                        
            inputVariety
            
            addButton
        }
            .navigationTitle("Add memo📌")
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    //MARK: - 기업 이름 입력란
    var inputName: some View {
        Section {
            HStack {
                TextField("Enter a Todo.", text: $name)
                    .disableAutocorrection(true)
                    .foregroundColor(.textFiledColor)
                
                
                if self.name.count > 0 {
                    Button(action: { self.name = "" }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
        } header: {
            Text("Todo ✏️")
                .foregroundColor(.textFiledColor)

        }
    }
    
    
    
    
    //MARK: - Variety 입력란
    var inputVariety: some View {
        Section {
            Picker("variety", selection: $variety) {
                ForEach(varietyOptions, id: \.self) {
                    Text($0).tag($0)
                }
            }.pickerStyle(.segmented)
            
        } header: {
            Text("Variety 👤")
                .foregroundColor(.textFiledColor)

        }
    }
    
    
    //MARK: - Add버튼
    var addButton: some View {
        Button(action: {
            self.updateInfo.addTodo(todo: todoInfo)
            goToDoList = false
        }) {
            Text("Add Todo Info")
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .frame(width: 350)
        }
    }
    
    
   
    

    
    
    //MARK: - 받은 정보로 Todo 타입으로 변환
    var todoInfo: Todo {
        Todo(name: self.name, variety: self.variety)
    }
}

//
//struct AddTodo_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTodo()
//    }
//}
