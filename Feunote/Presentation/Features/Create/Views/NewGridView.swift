//
//  NewGridView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import PartialSheet
import SwiftUI
struct NewGridView: View {

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
                }, label: {
                    NewButton(systemImageName: "note.text", buttonName: "Moment")
                })

                Spacer()

                // MARK: - here we have a bug

                // New  Todo
                Button(action: {
                    isShowingTodoEditor = true
                    playSound(sound: "sound-ding", type: "mp3")

                }, label: {
                    NewButton(systemImageName: "checkmark", buttonName: "Todo")

                })
            }

            HStack(alignment: .center, spacing: 0) {
                // New Person
                Button(action: {
                    isShowingPersonEditor = true
                    playSound(sound: "sound-ding", type: "mp3")

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
            CommitEditorView(commit: AmplifyCommit(commitType: .moment))
        }
        .partialSheet(isPresented: $isShowingTodoEditor) {
            CommitEditorView(commit: AmplifyCommit(commitType: .todo))

        }
        .partialSheet(isPresented: $isShowingPersonEditor) {
            CommitEditorView(commit: AmplifyCommit(commitType: .person))
        }
        .partialSheet(isPresented: $isShowingBranchEditor) {
            BranchEditorView(branch: AmplifyBranch(privacyType: .private, title: "", description: ""))
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
