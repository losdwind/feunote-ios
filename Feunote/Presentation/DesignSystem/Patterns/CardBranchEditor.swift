//
//  CardBranchEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI

enum BranchPrivacy:String, CaseIterable{
    case Public
    case Private
    case Team
}

struct CardBranchEditor: View {
    
    @Binding var title: String
    @Binding var description: String
    @Binding var selection:BranchPrivacy
    
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {
            EWTextField(input: $title, icon: nil, placeholder: "Title")
            EWTextFieldMultiline(input: $description, placeholder: "Description")

            EWPicker(selected: $selection, title: "Privacy")
            
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text("Add Members").font(Font.ewSubheadline)
                HStack(alignment: .center, spacing: 0) {
                    EWAvatarGroup(imageURLs: [])
                    EWAvatarAdd(action: {})
                }
                
            }
            
            
        }
        
    }
}

struct CardBranchEditor_Previews: PreviewProvider {
    @State static var title:String = ""
    @State static var description:String = ""
    @State static var selection:BranchPrivacy = BranchPrivacy.Private

    static var previews: some View {
        CardBranchEditor(title: $title, description: $description, selection: $selection)
    }
}
