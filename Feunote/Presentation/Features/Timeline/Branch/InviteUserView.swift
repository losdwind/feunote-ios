//
//  InviteUserView.swift
//  Beliski (iOS)
//
//  Created by Losd wind on 2021/11/9.
//

import SwiftUI
import Kingfisher

struct InviteUserView: View {
    
    @State var email:String = ""
    @ObservedObject var branchvm:BranchViewModel
    @State var users:[User] = [User]()
    
    @State var isConfirmingInvite:Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            HStack(alignment: .center, spacing: 20){
                TextField("Search", text: $email, prompt: Text("Put a email address"))
                    .foregroundColor(.accentColor)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                
                
                Button {
                    branchvm.searchUser(email: email) { users in
                        if let u = users{
                            self.users = u
                        }
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.pink)
                }
            } //: HStack
            
            
            
            ForEach(users){ user in
                
                HStack(alignment: .center, spacing: 25){
                    
                    KFImage(URL(string: user.profileImageURL!))
                        .resizable()
                        .placeholder {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40.0, height: 40.0)
                        .cornerRadius(20)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text(user.nickName!)
                            .font(.headline)
                            .foregroundColor(.accentColor)
                        
                        Text(user.email!)
                            .font(.footnote)
                        
                    }
                    
                    Button("Invite") {
                        isConfirmingInvite.toggle()
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    
                    
                    
                    
                    
                }
                
                .confirmationDialog(
                    "Are you sure you want to invite this user?",
                    isPresented: $isConfirmingInvite, presenting: user) {user in
                        Button {
                            if !branchvm.branch.memberIDs.contains(user.id!) {
                                branchvm.branch.memberIDs.append(user.id!)
                                branchvm.branch.memberIDsAvatar.append(user.profileImageURL!)
                                branchvm.branch.memberIDsNickname.append(user.nickName!)
                                branchvm.uploadBranch {success in
                                    if success {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        } label: {
                            Text("Confirm")
                        }
                        
                        
                        
                        Button("Cancel", role: .cancel) {
                            
                        }
                    }
            }//: ForEach
        } //: VStack
        .padding()
        
    }
    
}
    



struct InviteUserView_Previews: PreviewProvider {
    static var previews: some View {
        InviteUserView(branchvm: BranchViewModel())
    }
}
