//
//  TextField.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI


public struct EWTextField: View {
    
    @Binding var input: String
    var icon: Image?
    var placeholder: String
    @FocusState private var isfocus:Bool
    
    init(input:Binding<String>, icon:Image?, placeholder: String) {
        self._input = input
        self.icon = icon
        self.placeholder = placeholder
    }

    
    // MARK:  Body
    
    public var body: some View {
        
        HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge){
            if icon != nil {
                icon.foregroundColor(.ewGray900)
            }
            TextField("Input Field", text: $input, prompt: Text(placeholder))
                .focused($isfocus)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal,.ewPaddingHorizontalLarge)
        .foregroundColor(isfocus ? .ewPrimary100 : .ewGray50)
    }
}


public struct EWTextFieldMultiline: View {
    
    @Binding var input: String
    var placeholder: String
    @FocusState private var isfocus:Bool
    
    init(input:Binding<String> , placeholder: String) {
        self._input = input
        self.placeholder = placeholder
    }

    
    // MARK:  Body
    
    public var body: some View {
        ZStack {
                TextEditor(text: $input)
                    .lineLimit(3)
                    .focused($isfocus)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            if input.isEmpty {
                Text(placeholder)
                    .font(Font.ewBody)
                    .foregroundColor(.ewGray100)
                    .padding(.vertical, .ewPaddingVerticalSmall)
                    .padding(.horizontal,.ewPaddingHorizontalDefault)
            }
                
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal,.ewPaddingHorizontalLarge)
        .foregroundColor(isfocus ? .ewPrimary100 : .ewGray50)
    }
}




// MARK: Preview

struct TextField_Previews: PreviewProvider {
    @State static var input:String
    static var previews: some View {
        VStack(spacing: 20) {
            EWTextField(input: $input, icon: Image(systemName: "person.fill") , placeholder: "Adam Smith")
            EWTextFieldMultiline(input: $input, placeholder: "Something to say")
        }
    }
}
