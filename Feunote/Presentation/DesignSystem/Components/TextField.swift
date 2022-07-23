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
                .foregroundColor(.ewGray900)
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal,.ewPaddingHorizontalDefault)
        .background(isfocus ? Color.ewPrimary100 : Color.ewGray50, in: RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
    }
}


public struct EWSecureTextField: View {
    
    enum Field: Hashable {
        case plain
        case secure
    }
    
    @Binding var input: String
    var icon: Image?
    var placeholder: String
    @FocusState private var isfocus:Field?
    @State private var showPassword:Bool = false
    
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
            
            if showPassword {
                TextField("Input Field", text: $input, prompt: Text(placeholder))
                    .focused($isfocus, equals: .plain)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .foregroundColor(.ewGray900)
            } else {
                SecureField("Input Field", text: $input, prompt: Text(placeholder))
                    .focused($isfocus, equals: .secure)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .foregroundColor(.ewGray900)
            }
            Button(action: {
                self.showPassword.toggle()
                isfocus = showPassword ? .plain : .secure
            }, label: {
                Image(systemName: self.showPassword ? "eye.slash" : "eye")
                    .accentColor(self.showPassword ? .ewGray900 : .ewGray100 )
            })
        }
        .padding(.vertical, .ewPaddingVerticalSmall)
        .padding(.horizontal,.ewPaddingHorizontalDefault)
        .background((isfocus != nil) ? Color.ewPrimary100 : Color.ewGray50, in: RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
    }
}




public struct EWTextFieldMultiline: View {
    
    @Binding var input: String
    var placeholder: String
    @FocusState private var isfocus:Bool
    
    init(input:Binding<String> , placeholder: String) {
        self._input = input
        self.placeholder = placeholder
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    // MARK:  Body
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $input)
                .focused($isfocus)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .foregroundColor(.ewGray900)
            if !isfocus {
                Text(placeholder)
                    .font(Font.ewBody)
                    .foregroundColor(.ewGray100)
            }
        }
        .frame(maxHeight:200)
        .padding(.vertical, .ewPaddingVerticalSmall)
        .padding(.horizontal,.ewPaddingHorizontalDefault)
        .background(isfocus ? Color.ewPrimary100 : Color.ewGray50, in: RoundedRectangle(cornerRadius: .ewCornerRadiusDefault))
        
    }
}




// MARK: Preview

struct TextField_Previews: PreviewProvider {
    @State static var input:String = ""
    static var previews: some View {
        VStack(spacing: 20) {
            EWTextField(input: $input, icon: Image(systemName: "person.fill") , placeholder: "Adam Smith")
            EWTextFieldMultiline(input: $input, placeholder: "Something to say")
        }
    }
}
