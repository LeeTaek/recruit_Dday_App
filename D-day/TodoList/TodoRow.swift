//
//  TodoRow.swift
//  D-day
//
//  Created by 이택성 on 2022/05/18.
//

import SwiftUI
import RealmSwift

struct TodoRow: View {
    @ObservedRealmObject var todo: TodoViewModel

    
    var body: some View {
        HStack {
            
            varietyImage
            
            Text("\(todo.name)")
                .foregroundColor(.textFiledColor)
                .fontWeight(.medium)
            
            
            Spacer()
            
            checkButton
            
        }
    }
    
 
    
    //MARK: - Todo 종류에 따른 이미지
    var varietyImage: some View {
        switch todo.variety {
        case "CS공부" :
            return Image(systemName: "desktopcomputer")
                .foregroundColor(.studyCS)
            
        case "App만들기" :
            return Image(systemName: "app.badge")
                .foregroundColor(.makeApp)
            
        case "취업지원" :
            return Image(systemName: "rectangle.inset.filled.and.person.filled")
                .foregroundColor(.applyRecruit)
            
        default:
            return Image(systemName: "lasso")
                .foregroundColor(.etc)
        }
        
    }
    
    
    
    //MARK: - Check 버튼
    var checkButtonImage: some View {
        todo.check ? Image(systemName: "checkmark.circle").foregroundColor(.applyRecruit) : Image(systemName: "circle").foregroundColor(.textFiledColor)
        
    }
    
    var checkButton: some View {
        checkButtonImage
             .onTapGesture {
                 todo.toggleTodo()
             }
             .animation(.easeInOut, value: todo.check)
    }


    
    
}

//struct TodoRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoRow(todo: )
//    }
//}
