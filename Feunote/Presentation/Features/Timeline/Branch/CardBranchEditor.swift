//
//  CardBranchEditor.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/10.
//

import SwiftUI


struct EWCardBranchEditor: View {
    
    @Binding var title: String
    @Binding var description: String
    @Binding var selection:PrivacyType
    @State var coverImage:UIImage?
    @State private var isShowingMemberSelector:Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalLarge) {

            ZStack(alignment: .center){
                if(coverImage != nil){
                    Image(uiImage: coverImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                EWAvatarAdd(image: $coverImage,style: .medium)
            }
                .frame(height:150)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.ewGray50)
                    .cornerRadius(.ewCornerRadiusDefault)
                
            
            EWTextField(input: $title, icon: nil, placeholder: "Title")
            
            EWTextFieldMultiline(input: $description, placeholder: "Description")

            EWPicker(selected: $selection, title: "Privacy")
            
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                Text("Add Members").font(Font.ewSubheadline)
                HStack(alignment: .center, spacing: 0) {
                    EWAvatarGroup(images: [])
                    
                    Button("Add Member") {
                        isShowingMemberSelector.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowingMemberSelector){
                AddMemberView()
            }
            
            
        }
        
    }
}

struct EWCardBranchEditor_Previews: PreviewProvider {
    @State static var title:String = ""
    @State static var description:String = ""
    @State static var selection:PrivacyType = .private
    @State static var coverImage:UIImage?

    static var previews: some View {
        EWCardBranchEditor(title: $title, description: $description, selection: $selection)
            .previewLayout(.sizeThatFits)
    }
}
