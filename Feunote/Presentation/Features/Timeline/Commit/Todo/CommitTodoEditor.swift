//
//  SwiftUIView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI
import Amplify
struct CommitTodoEditor: View {

    @Binding var todo:AmplifyCommit
    var contentPlaceholder:String = "What is Your Goal"
    var descriptionPlaceholder:String = "Detail Description..."
    
    var body: some View {

        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge){
            EWTextField(input: $todo.titleOrName ?? "", icon: nil, placeholder: contentPlaceholder)
            EWTextFieldMultiline(input: $todo.description ?? "", placeholder: descriptionPlaceholder)
            
            VStack(alignment: .leading, spacing: .ewPaddingHorizontalSmall) {
                HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                        Image("date")
                            .foregroundColor(.ewGray100)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Start")
                            .font(.ewSubheadline)
                            .foregroundColor(.ewGray900)
                            .frame(width: 50, alignment: .leading)
                    }
                    
                    DatePicker("Start DatePicker", selection: Binding(get: {
                        self.todo.todoStart?.foundationDate ?? Date.now
                    }, set: {
                            self.todo.todoStart =
                            Temporal.DateTime($0)

                    }), in: Date()..., displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.automatic)
                            .labelsHidden()
                    
                }
                
                HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                    HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall){
                        Image("date")
                            .foregroundColor(.ewGray100)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("End")
                            .font(.ewSubheadline)
                            .foregroundColor(.ewGray900)
                            .frame(width: 50, alignment: .leading)

                    }
                    
                    
                    DatePicker("End DatePicker", selection: Binding(get: {
                        self.todo.todoEnd?.foundationDate ?? Date.now
                    }, set: {
                        self.todo.todoEnd =
                        Temporal.DateTime($0)
                    }), in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.automatic)
                        .labelsHidden()
                }
            }

        }

    }
}

struct CommitTodoEditor_Previews: PreviewProvider {

    @State static var todo:AmplifyCommit = AmplifyCommit(commitType: .todo)
    static var previews: some View {
        CommitTodoEditor(todo: $todo)
    }
}
