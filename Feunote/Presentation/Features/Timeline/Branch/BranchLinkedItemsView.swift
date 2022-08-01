//
//  BranchLinkedItemsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct BranchLinkedItemsView: View {

    @EnvironmentObject var commitvm:CommitViewModel
    @Environment(\.dismiss) var dismiss


    var commitList:[FeuCommit]
    @Binding var searchInput:String

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                ForEach(commitList, id: \.id) { commit in

                    switch commit.commitType {
                    case .moment:
                        EWCardMoment(title: commit.titleOrName, content: commit.description, images: commit.photos, audios: commit.audios, videos: commit.videos, updatedAt: commit.updatedAt, action: {})
                    case .person:
                        EWCardPerson(name: commit.titleOrName , avatarImage: commit.personAvatar, address: commit.personAddress, birthday: commit.personBirthday, description: commit.description)
                    case .todo:
                        EWCardTodo(content: commit.titleOrName, description: commit.description, completion: commit.todoCompletion, start: commit.todoStart, end: commit.todoEnd, action:{
                            Task {await commitvm.toggleTodoCompletion(todo: commit)}
                        })
                    }


                }

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrow-left-2")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                            .foregroundColor(.ewBlack)
                    }

                }

                ToolbarItem(placement: .principal) {
                    Text("Branch Details")
                        .font(.ewHeadline)
                        .foregroundColor(.ewBlack)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SearchView(input: $searchInput)
                    } label: {
                        Image("search")
                    }


                }
            })
            .padding()

        }
    }
}

struct BranchLinkedItemsView_Previews: PreviewProvider {

    @State static var searchInput:String = ""
    static var previews: some View {
        BranchLinkedItemsView(commitList: [], searchInput: $searchInput)
        
    }
}
