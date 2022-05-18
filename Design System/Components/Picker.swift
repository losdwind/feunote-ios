//
//  Picker.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/18.
//

import SwiftUI

SegmentedPickerStyle
extension EWPickerStyle:PickerStyle {
    
}

struct Picker: View {
    var body: some View {
        Picker()
            .pickerStyle(.segmented)
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        Picker()
    }
}
