//
//  MomentView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI

struct MomentListView: View {

    @ObservedObject var commitvm:CommitViewModel


    @State var isUpdatingMoment = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView: Bool = false


    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                ForEach(commitvm.fetchedAllCommits.filter({ commit in
                    return commit.commitType == .moment
                }), id: \.id) { moment in

 
                    EWCardMoment(title: commitvm.commit.titleOrName, content: commitvm.commit.description, images: commitvm.commit.photos, audios: commitvm.commit.audios, videos: commitvm.commit.videos, updatedAt: commitvm.commit.updatedAt, action: {})


                        .background {
                        NavigationLink(destination: EmptyView(), isActive: $isShowingLinkedItemView) {
                            EmptyView()
                        }
                    }
                        .contextMenu {
                        // Delete
                        Button(action: {
                            Task {
                                await commitvm.deleteCommit(commit: moment)
                            }

                        }
                               , label: { Label(
                                                    title: { Text("Delete") },
                                                    icon: { Image(systemName: "trash.circle") }) })


                        // Edit
                        Button(action: {
                            
                            commitvm.commit = moment
                            isUpdatingMoment = true

                        }
                               , label: { Label(
                                                    title: { Text("Edit") },
                                                    icon: { Image(systemName: "pencil.circle") }) })


                        // Link
                        Button(action: {
                            isShowingLinkView = true

                        }
                               , label: { Label(
                                                    title: { Text("Link") },
                                                    icon: { Image(systemName: "link.circle") }) })

                    }
                        .onTapGesture(perform: {
                        isShowingLinkedItemView.toggle()

                    })


                        .sheet(isPresented: $isUpdatingMoment) {
                        // MARK: - think about the invalide id, because maybe the moment haven't yet been uploaded
                            MomentEditorView(commitvm: commitvm )
                    }


                        .sheet(isPresented: $isShowingLinkView) {
//                        SearchAndLinkingView(item: moment, searchvm: searchvm, tagPanelvm: tagPanelvm)
                    }

                }

            }
                .padding()
                .frame(maxWidth: 640)

        }
    }

}

struct MomentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentListView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase())
)
    }
}
