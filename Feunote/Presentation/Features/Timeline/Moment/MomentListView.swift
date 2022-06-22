//
//  MomentView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI

struct MomentListView: View {

    @ObservedObject var momentvm: MomentViewModel


    @State var isUpdatingMoment = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView: Bool = false


    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
                ForEach(momentvm.fetchedMoments, id: \.id) { moment in

                    MomentItemView(moment: moment, tagNames: moment.tagNames, OwnerItemID: moment.id)
                    EWCardMoment(title: momentvm.moment.title, content: momentvm.moment.content, imageURLs: momentvm.images, audioURLs: momentvm.audios, videoURLs: momentvm.videos, updatedAt: Date.now, action: {})


                        .background {
                        NavigationLink(destination: EmptyView(), isActive: $isShowingLinkedItemView) {
                            EmptyView()
                        }
                    }
                        .contextMenu {
                        // Delete
                        Button(action: {
                            task {
                                await momentvm.saveMoment()
                            }

                        }
                               , label: { Label(
                                                    title: { Text("Delete") },
                                                    icon: { Image(systemName: "trash.circle") }) })


                        // Edit
                        Button(action: {
                            
                            momentvm.moment = moment
                            momentvm.localTimestamp = moment.localTimestamp?.dateValue() ?? Date(timeIntervalSince1970: 0)
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
                        MomentEditorView(momentvm: momentvm)
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
        MomentListView(momentvm: MomentViewModel(), dataLinkedManager: DataLinkedManager(), searchvm: SearchViewModel(), tagPanelvm: TagPanelViewModel())
    }
}
