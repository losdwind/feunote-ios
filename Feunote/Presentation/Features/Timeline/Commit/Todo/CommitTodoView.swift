//
//  CardTask.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/9.
//

import SwiftUI

struct CommitTodoView: View {


    var todo: AmplifyCommit
    var action: () -> Void

    @State private var isCompleted: Bool?


    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
            EWRadio(isChecked: $isCompleted ?? false)
                .onTapGesture {
                    isCompleted?.toggle()
                    action()
                }
            VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                Text(todo.titleOrName ?? "Too important, cannot say it").font(Font.ewHeadline)
                if todo.description != nil {
                    Text(todo.description!).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
                if todo.todoStart != nil {

                    Text(todo.todoStart!.foundationDate.formatted().description).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
                if todo.todoEnd != nil {
                    Text(todo.todoEnd!.foundationDate.formatted().description).font(Font.ewFootnote).foregroundColor(.ewGray900)
                }
            }
            Spacer(minLength: .ewPaddingHorizontalLarge)

            // MARK: - Todo Add the team members
        }
        .onAppear(perform: {
            isCompleted = todo.todoCompletion
        })
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .padding(.vertical, .ewPaddingVerticalDefault)
        .background(Color.ewGray50)
        .cornerRadius(.ewCornerRadiusDefault)
    }
}

struct EWCardTask_Previews: PreviewProvider {
    @State static var completion: Bool? = true
    static var previews: some View {
        CommitTodoView(todo: AmplifyCommit(commitType: .todo), action: {})
            .previewLayout(.sizeThatFits)
    }
}
