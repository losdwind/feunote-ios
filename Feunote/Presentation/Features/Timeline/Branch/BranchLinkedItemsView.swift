//
//  BranchLinkedItemsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/21.
//

import SwiftUI

struct BranchLinkedItemsView: View {
    var branch:FeuBranch
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BranchLinkedItemsView_Previews: PreviewProvider {
    
    @State static var fakeBranch = FeuBranch()
    
    static var previews: some View {
        BranchLinkedItemsView(branch: fakeBranch)
            .task {
                do {
                    fakeBranch = try await FakeViewDataMapper().branchDataTransformer(branch: fakeAmplifyBranchOpen1)
                }catch {
                    
                }
                
            }
        
    }
}
