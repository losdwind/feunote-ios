//
//  TextField.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI


public struct EWTextFieldIconic: View {
    
    
    var placeholder: String
    var icon: Image? = nil
    var commit: ()->() = {}
    @FocusState private var isfocus:Bool
    @State var input: String = ""
    
    init(_ placeholder: String, icon: Image, onCommit: @escaping ()->() = { }) {
        self.placeholder = placeholder
        self.icon = icon
        self.commit = onCommit
    }

    
    // MARK:  Body
    
    public var body: some View {
        
        HStack{
            icon.foregroundColor(.ewGray900)
            TextField("Input Field", text: $input, prompt: Text(placeholder))
                .focused($isfocus)
                .onSubmit(commit)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
        .padding(.vertical, 8)
        .padding(.horizontal,16)
            .foregroundColor(isfocus ? .ewPrimary100 : .ewGray50)
    }
}

// MARK: Preview

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            EWTextFieldIconic("Thats a default Textfield",icon: Image(systemName: "person.fill") , onCommit: {print("submitted")})
        }
        .padding()
    }
}
