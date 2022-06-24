//
//  SingleEntryView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI

struct SingleEntryView: View {
    var number:Int
    var text:String
    var body: some View {
        VStack(alignment: .center, spacing: 5, content: {
            Text(String(number))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            
            Capsule()
                .fill(Color.gray)
                .frame(width: 20, height: 2, alignment: .center)
            
            Text(text)
                .foregroundColor(.gray)
        })
    }
}

struct SingleEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SingleEntryView(number: 111, text: "Apples")
    }
}
