//
//  InputFieldView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

struct InputFieldView: View {
    private let title: String
    @Binding private var text: String
    private let isSecure: Bool

    init(_ title: String, text: Binding<String>, isSecure: Bool = false) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
    }

    var body: some View {
        createInput()
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(10)
            .background(Color.white)
            .border(Color.gray)
    }

    @ViewBuilder private func createInput() -> some View {
        if isSecure {
            SecureField(title, text: $text)
        } else {
            TextField(title, text: $text)
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var title = "kk"
    static var isSecure = false
    @State static var text = "ff"
    static var previews: some View {
        InputFieldView(title, text: $text, isSecure: isSecure)
    }
}
