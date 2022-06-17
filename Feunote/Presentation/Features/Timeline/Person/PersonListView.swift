//
//  PersonListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/25.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject var personvm: PersonViewModel
    @ObservedObject var dataLinkedManager: DataLinkedManager
    @ObservedObject var searchvm:SearchViewModel
    @ObservedObject var tagPanelvm: TagPanelViewModel
    @ObservedObject var timelineManager:TimelineManager
    
    @State var isUpdatingPerson: Bool = false
    @State var isShowingPersonDetail: Bool = false
    @State var isShowingLinkView:Bool = false
    @State var isShowingLinkedItemView: Bool = false
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: true){
                LazyVStack{
                    ForEach(personvm.fetchedPersons){ person in
                        
                        VStack{
                        if timelineManager.theme == .full {
                            PersonItemView(person: person, tagNames: person.tagNames, OwnerItemID: person.id, isShowingPhtos: true, isShowingDescription: true, isShowingTags: true)
                        } else {
                            PersonItemView(person: person, tagNames: person.tagNames, OwnerItemID: person.id, isShowingPhtos: false, isShowingDescription: false, isShowingTags: true)
                            
                        }
                        }
                                .background{
                                    NavigationLink(destination:LinkedItemsView(dataLinkedManager: dataLinkedManager), isActive: $isShowingLinkedItemView){
                                        EmptyView()
                                    }
                                }
                                .contextMenu{
                                    
                                    // Detail
                                    Button {
                                        isShowingPersonDetail.toggle()
                                    } label: {
                                        Label(
                                         title: { Text("Detail") },
                                         icon: { Image(systemName: "trash.circle") })
                                    }

                                    // Delete
                                    Button(action:{
                                        personvm.deletePerson(person: person){success in
                                            if success {
                                                personvm.fetchPersons(handler: {_ in})
                                            }
                                        }
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Delete") },
                                            icon: { Image(systemName: "trash.circle") })})
                                    
                                    
                                    // Edit
                                    Button(action:{
                                        personvm.person = person
                                        personvm.birthday = person.birthday.dateValue()
                                        isUpdatingPerson = true
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Edit") },
                                            icon: { Image(systemName: "pencil.circle") })})
                                    
                                    
                                    // Link
                                    Button(action:{
                                        isShowingLinkView = true
                                        
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Link") },
                                            icon: { Image(systemName: "link.circle") })})
                                    
                                }
                                .sheet(isPresented: $isShowingPersonDetail){
                                    PersonDetailView(person: person)
                                }
                                .sheet(isPresented: $isShowingLinkView, onDismiss: {
                                    personvm.uploadPerson { success in
                                        personvm.fetchPersons(handler: {_ in})
                                    }
                                }){
                                    SearchAndLinkingView(item: person,searchvm: searchvm, tagPanelvm: tagPanelvm)
                                }
                                .sheet(isPresented: $isUpdatingPerson){
                                    PersonEditorView(personTagvm:TagViewModel(tagNamesOfItem: person.tagNames, ownerItemID: personvm.person.id, completion: {_ in}) , personvm: personvm)
                                }
                                .onTapGesture(perform: {
                                    isShowingLinkedItemView.toggle()
                                    dataLinkedManager.linkedIds = person.linkedItems
                                    dataLinkedManager.fetchItems { success in
                                        if success {
                                            print("successfully loaded the linked Items from DataLinkedManager")

                                        } else {
                                            print("failed to loaded the linked Items from DataLinkedManager")
                                        }
                                    }
                                })
                    
                        

                        
                    }
                }
                .padding()
                .frame(maxWidth: 640)

            }
            
        
            
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView(personvm: PersonViewModel(), dataLinkedManager: DataLinkedManager(), searchvm: SearchViewModel(), tagPanelvm: TagPanelViewModel(), timelineManager: TimelineManager())
    }
}
