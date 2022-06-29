//
//  BranchCardEditingView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/28.
//

import SwiftUI

import Kingfisher

struct BranchCardEditorView: View {
    
    
    @ObservedObject var branchvm: BranchViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // Show Picker..
    @State var showDatePicker = false
    
    @State var currentBranchOpenessType = "Public"
    
    @State var isShowingAddCollaboratorView:Bool = false
    
    
    @State var privateStatus:BranchPrivacy = BranchPrivacy.Private
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge){
                
                EWNavigationBar(title: "Branch", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {print("action left activated")}, actionRight: {print("action right activated")})
                EWCardBranchEditor(title: $branchvm.branch.title, description: $branchvm.branch.description, selection: $privateStatus)
                
                VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                    
                    Text("Select Colloborators")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    
                    HStack(spacing: 0){
                        
                        
                        
                        
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
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            isShowingAddCollaboratorView.toggle()
                        } label: {
                            Text("Add \(branchvm.branch.members != nil ? branchvm.branch.members!.count:0)/5")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(
                                    
                                    Capsule()
                                        .stroke(.black,lineWidth: 1)
                                )
                        }
                        
                    }
                    
                }
                
            }
            .padding()
        }
            .transition(.move(edge: .bottom))
            .sheet(isPresented: $isShowingAddCollaboratorView) {
//                InviteUserView(branchvm: branchvm)
                EmptyView()
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
                .foregroundColor(title != currentType ? .black : .white)
                .padding(.vertical,8)
            // Max Width...
                .frame(maxWidth: .infinity)
                .background(
                    
                    Capsule()
                        .stroke(.black,lineWidth: 1)
                )
                .background(
                    
                    Capsule()
                        .fill(.black.opacity(title == currentType ? 1 : 0))
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
        BranchCardEditorView(branchvm: BranchViewModel(saveBranchUserCase: SaveBranchUseCase(), getAllBranchesUseCase: GetAllBranchesUseCase(), deleteBranchUseCase: DeleteBranchUseCase()))
    }
}
