//
//  DropDownMenu.swift
//  Feunote
//
//  Created by Losd wind on 2022/5/18.
//

import SwiftUI

struct DropDownMenu: View {
    var menuItemTexts:[String]
    var menuItemImages:[String]
    var menuItem
    var menuTitle:String
    var body: some View {
        Menu(menuTitle) {
            ForEach(menuItems, id:\.self){ (key, value) in
                EWButton(text: key, image: <#T##Image?#>, style: <#T##EWButton.Style#>, color: <#T##Color#>, action: <#T##() -> Void#>)
            }
            .menuStyle(.borderlessButton)
        }
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu()
    }
}
