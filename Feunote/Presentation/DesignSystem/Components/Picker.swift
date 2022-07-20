//
//  Picker.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/18.
//

/*
Reference: 
how to build a custom ios segmented picker
https://betterprogramming.pub/custom-ios-segmented-control-with-swiftui-473b386d0b51
*/


import SwiftUI

struct EWPicker<T: Hashable & CaseIterable, V: View>: View {
    
    @Binding var selected: T
    var title: String? = nil
    
    let mapping: (T) -> V
    
    var body: some View {
        Picker(selection: $selected, label: Text(title ?? "")) {
            ForEach(Array(T.allCases), id: \.self) {
                mapping($0).tag($0)
            }
        }
        
    }
}

extension EWPicker where T: RawRepresentable, T.RawValue == String, V == Text {
    init(selected: Binding<T>, title: String? = nil) {
        self.init(selected: selected, title: title) {
            Text($0.rawValue)
        }
    }
}
