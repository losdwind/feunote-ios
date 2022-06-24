//
//  PersonListView.swift
//  Beliski
//
//  Created by Wind Losd on 2021/5/25.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject var personvm: PersonViewModel
    
    @State var isUpdatingPerson: Bool = false
    @State var isShowingPersonDetail: Bool = false
    @State var isShowingLinkView:Bool = false
    @State var isShowingLinkedItemView: Bool = false
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                    ForEach(personvm.fetchedPersons, id:\.id){ person in
                        EWCardPerson(name: personvm.person.name, avatarURL: personvm.person.avatarURL, address: personvm.person.address, birthday: personvm.person.birthday, description: personvm.person.description)
                                .background{
                                    NavigationLink(destination:EmptyView(), isActive: $isShowingLinkedItemView){
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
                                        Task {
                                            
                                        await personvm.deletePerson(person: person)
                                        }
                                        
                                    }
                                           ,label:{Label(
                                            title: { Text("Delete") },
                                            icon: { Image(systemName: "trash.circle") })})
                                    
                                    
                                    // Edit
                                    Button(action:{
                                        personvm.person = person
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
                                }){
//                                    SearchAndLinkingView(item: person,searchvm: searchvm, tagPanelvm: tagPanelvm)
                                }
                                .sheet(isPresented: $isUpdatingPerson){
                                    PersonEditorView(personvm: personvm)
                                }
                                .onTapGesture(perform: {
                                    isShowingLinkedItemView.toggle()
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
        PersonListView(personvm: PersonViewModel(savePersonUserCase: SavePersonUseCase(), getAllPersons: GetAllPersonsUseCase(), deletePersonUseCase: DeletePersonUseCase()))
    }
}
