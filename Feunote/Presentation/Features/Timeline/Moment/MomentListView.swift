//
//  MomentView.swift
//  Beliski-Firebase
//
//  Created by Wind Losd on 2021/9/17.
//

import SwiftUI

struct MomentListView: View {

    @ObservedObject var momentvm: MomentViewModel
    @ObservedObject var dataLinkedManager: DataLinkedManager
    @ObservedObject var searchvm: SearchViewModel
    @ObservedObject var tagPanelvm: TagPanelViewModel

    @State var isUpdatingMoment = false
    @State var isShowingLinkedItemView = false
    @State var isShowingLinkView: Bool = false


    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: 20) {
                ForEach(momentvm.fetchedMoments, id: \.id) { moment in

                    MomentItemView(moment: moment, tagNames: moment.tagNames, OwnerItemID: moment.id)


                        .background {
                        NavigationLink(destination: LinkedItemsView(dataLinkedManager: dataLinkedManager), isActive: $isShowingLinkedItemView) {
                            EmptyView()
                        }
                    }
                        .contextMenu {
                        // Delete
                        Button(action: {
                            momentvm.deleteMoment(moment: moment) { success in
                                if success {
                                    momentvm.fetchMoments(handler: { _ in })
                                }

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
                        dataLinkedManager.linkedIds = moment.linkedItems
                        dataLinkedManager.fetchItems { success in
                            if success {
                                print("successfully loaded the linked Items from DataLinkedManager")

                            } else {
                                print("failed to loaded the linked Items from DataLinkedManager")
                            }
                        }
                    })


                        .sheet(isPresented: $isUpdatingMoment) {
                        // MARK: - think about the invalide id, because maybe the moment haven't yet been uploaded
                        MomentEditorView(momentvm: momentvm, momentTagvm: TagViewModel(tagNamesOfItem: momentvm.moment.tagNames, ownerItemID: momentvm.moment.id, completion: { _ in }))
                    }


                        .sheet(isPresented: $isShowingLinkView) {
                        SearchAndLinkingView(item: moment, searchvm: searchvm, tagPanelvm: tagPanelvm)
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
