//
//  TodoRowItemView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/8.
//

import SwiftUI

struct TodoRowItemView: View {
    
    var todo:Todo
    @State var completion:Bool
    
    init(todo:Todo){
        self.todo = todo
        self.completion = todo.completion
    }
    var body: some View {
        withAnimation {
            Toggle(isOn: $completion){
                if todo.content != "" {
                    Text(todo.content)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(completion ? Color.pink : Color.accentColor)
                } else {
                    VStack(alignment: .leading){
                        
                        HStack(alignment: .firstTextBaseline, spacing: 5){
                            Text("W ->").font(.headline).fontWeight(.semibold)
                                .frame(width:40,alignment: .leading)
                            Text(todo.wish)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(completion ? Color.pink : Color.accentColor)
                        }
                       
                        HStack(alignment: .firstTextBaseline, spacing: 5){
                            Text("O ->").font(.headline).fontWeight(.semibold)
                                .frame(width:40,alignment: .leading)

                            Text(todo.outcome)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(completion ? Color.pink : Color.accentColor)
                        }
                        
                        HStack(alignment: .firstTextBaseline, spacing: 5){
                            Text("O -> ").font(.headline).fontWeight(.semibold)
                                .frame(width:40,alignment: .leading)

                            Text(todo.obstacle)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(completion ? Color.pink : Color.accentColor)
                        }
                        
                        HStack(alignment: .firstTextBaseline, spacing: 5){
                            Text("P -> ").font(.headline).fontWeight(.semibold)
                                .frame(width:40,alignment: .leading)

                            Text(todo.plan)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(completion ? Color.pink : Color.accentColor)
                        }
                        
                        
                    }
                    
                }
                Spacer()
                
        } //: Toggle
        .toggleStyle(CheckboxStyle())
        .onChange(of: completion) { newValue in
            let tempTodovm = TodoViewModel()
            tempTodovm.todo = todo
            tempTodovm.todo.completion = newValue
            tempTodovm.uploadTodo{_ in }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(18)
        
    }
        
    }
}

//struct TodoRowItemView_Previews: PreviewProvider {
//    
//    init(){
//        self.todovm = TodoViewModel()
//        todovm.fetchTodos(handler: {_ in })
//        self.todo = self.todovm.fetchedTodos[0]
//    }
//    
//    @State var todo:Todo
//    @StateObject var todovm: TodoViewModel
//    
//
//    static var previews: some View {
//        TodoRowItemView(todo: $todo, todovm: TodoViewModel())
//            .previewLayout(.sizeThatFits)
//        
//    }
//}

