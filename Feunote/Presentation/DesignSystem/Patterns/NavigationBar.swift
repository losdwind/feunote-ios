//
//  NavigationBar.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import SwiftUI

struct EWNavigationBar: View {
    var title:String
    var iconLeftImage:Image
    var iconRightImage:Image
    var actionLeft:() -> Void
    var actionRight:() -> Void

    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault){
            
            Button {
                
                withAnimation{
                    actionLeft()
                }
                
            } label: {
                iconLeftImage
                    .font(.ewHeadline)
            }
            
            Spacer()

            Button {
                
                withAnimation{
                    actionRight()
                }
                
            } label: {
                iconRightImage
                    .font(.ewHeadline)
            }
            
        }
        .overlay(
            Text(title)
                .font(.ewHeadline)
        )
        .foregroundColor(.ewBlack)
        .frame(height: 48, alignment: .center)

    }
}

struct EWNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        EWNavigationBar(title: "Test", iconLeftImage: Image("search"), iconRightImage: Image("check"), actionLeft: {}, actionRight: {})
            .padding()
    }
}
