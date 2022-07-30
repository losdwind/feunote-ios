//
//  BranchCardEditingView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import SwiftUI

import Kingfisher

struct BranchCardEditorView: View {
    
    
    @EnvironmentObject var branchvm: BranchViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // Show Picker..
    @State var showDatePicker = false
    
    @State var currentBranchOpenessType = "Public"
    
    @State var isShowingAddCollaboratorView:Bool = false

    @State var searchInput:String = ""
    
    @State var privateStatus:PrivacyType = .private
    var body: some View {
                VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){

                    EWNavigationBar(title: "Branch", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {
                        presentationMode.wrappedValue.dismiss()
                        branchvm.branch = FeuBranch(privacyType: .private, title: "", description: "")
                    }, actionRight: {
                        Task {
                            await branchvm.saveBranch()
                            presentationMode.wrappedValue.dismiss()

                        }
                    })
                    EWCardBranchEditor(title: $branchvm.branch.title, description: $branchvm.branch.description, selection: $privateStatus)

                    VStack(alignment: .leading, spacing:.ewPaddingVerticalDefault) {

                        Text("Select Colloborators")
                            .font(.ewHeadline)
                            .foregroundColor(.ewGray900)


                        HStack(spacing: .ewPaddingVerticalDefault){


                            EWAvatarGroup(images: [UIImage(named: "demo-person-1")!, UIImage(named: "demo-person-2")!])

                            //                        ForEach(branchvm.branch.coverImage,id: \.self){avatar in
                            //
                            //                            KFImage(URL(string: avatar))
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fill)
                            //                                .background(Circle()
                            //                                                .stroke(.black,lineWidth: 1))
                            //                                .frame(width: 30, height: 30)
                            //                                .cornerRadius(15)
                            //                        }

                            Spacer()
                            Button {
                                isShowingAddCollaboratorView.toggle()
                            } label: {
                                if let members = branchvm.branch.actions?.filter({$0.actionType == .participate}), (members.count != 0) {
                                    Text("Add \(members.count)/5")
                                        .font(.footnote)
                                        .foregroundColor(.ewBlack)
                                        .padding(.vertical,10)
                                        .padding(.horizontal,20)
                                        .background(

                                            Capsule()
                                                .stroke(Color.ewBlack,lineWidth: 1)
                                        )

                                } else {
                                    Text("Add 2/5")
                                        .font(.footnote)
                                        .foregroundColor(.ewBlack)
                                        .padding(.vertical,10)
                                        .padding(.horizontal,20)
                                        .background(

                                            Capsule()
                                                .stroke(Color.ewBlack,lineWidth: 1)
                                        )
                                }

                            }

                        }

                    }

                }
                .padding()

                if isShowingAddCollaboratorView {
                    SearchView(input: $searchInput)
                        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
                        .background(Color.white)

                }

            }




        

}
// Meeting tab Button...
struct OpenessTabButton: View{
    var title: String
    
    @Binding var currentType: String
    
    var body: some View{
        
        Button {
            
            withAnimation{
                currentType = title
            }
            
        } label: {
            Text(title)
                .font(.footnote)
                .foregroundColor(title != currentType ? .ewBlack : .white)
                .padding(.vertical,8)
            // Max Width...
                .frame(maxWidth: .infinity)
                .background(
                    
                    Capsule()
                        .stroke(Color.ewBlack,lineWidth: 1)
                )
                .background(
                    
                    Capsule()
                        .fill(Color.ewBlack.opacity(title == currentType ? 1 : 0))
                )
        }
        
    }
}

// Custom Date Picker...
struct CustomDatePicker: View{
    
    @Binding var date: Date
    @Binding var showPicker: Bool
    
    var body: some View{
        
        ZStack{
            
            // Blur Effect...
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            DatePicker("", selection: $date, displayedComponents: [.date,.hourAndMinute])
                .labelsHidden()
            
            // Close Button...
            Button {
                
                withAnimation{
                    showPicker.toggle()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(.gray,in: Circle())
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
        }
        .opacity(showPicker ? 1 : 0)
    }
}

struct BranchCardEditorView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCardEditorView()
    }
}
