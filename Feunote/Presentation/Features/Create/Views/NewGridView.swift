//
//  NewGridView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import PartialSheet
import SwiftUI
struct NewGridView: View {
    @EnvironmentObject var commitvm: CommitViewModel
    @EnvironmentObject var branchvm: BranchViewModel

    @State var isShowingMomentEditor = false
    @State var isShowingTodoEditor = false
    @State var isShowingPersonEditor = false
    @State var isShowingBranchEditor = false
    @State var isShowingAlert = false

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
            HStack(alignment: .center, spacing: 0) {
                // New Moment
                Button(action: {
                    isShowingMomentEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .moment
                }, label: {
                    NewButton(systemImageName: "note.text", buttonName: "Moment")
                })

                Spacer()

                // MARK: - here we have a bug

                // New  Todo
                Button(action: {
                    isShowingTodoEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .todo

                }, label: {
                    NewButton(systemImageName: "checkmark", buttonName: "Todo")

                })
            }

            HStack(alignment: .center, spacing: 0) {
                // New Person
                Button(action: {
                    isShowingPersonEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .person

                }, label: {
                    NewButton(systemImageName: "person.fill", buttonName: "Person")

                })

                Spacer()
                // New Branch
                Button(action: {
                    isShowingBranchEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                }, label: {
                    NewButton(systemImageName: "arrow.triangle.branch", buttonName: "Branch")

                })
            }
        }
        .partialSheet(isPresented: $isShowingMomentEditor) {
            MomentEditorView()
        }
        .partialSheet(isPresented: $isShowingTodoEditor) {
            TodoEditorView()
        }
        .partialSheet(isPresented: $isShowingPersonEditor) {
            PersonEditorView()
        }
        .partialSheet(isPresented: $isShowingBranchEditor) {
            BranchCardEditorView()
        }
    }
}

struct NewGridView_Previews: PreviewProvider {
    static var previews: some View {
        NewGridView()
    }
}

struct NewButton: View {
    var systemImageName: String
    var buttonName: String
    var body: some View {
        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
            Image(systemName: systemImageName)
                .font(.ewHeadline)
            Text(buttonName)
                .font(.ewHeadline)
        }
        .padding(.vertical, .ewPaddingVerticalLarge)
        .padding(.horizontal, .ewPaddingHorizontalLarge)
        .foregroundColor(Color.ewSecondaryBase)
        .frame(width: 164, height: 164)
        .background(Color.ewGray50, in: RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
    }
}
