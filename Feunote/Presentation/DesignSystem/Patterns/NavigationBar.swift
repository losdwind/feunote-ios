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
        HStack{
            
            Button {
                
                withAnimation{
                    actionLeft()
                }
                
            } label: {
                iconLeftImage
                    .font(.ewHeadline)
                    .foregroundColor(.ewGray900)
            }
            
            Spacer()

            Button {
                
                withAnimation{
                    actionRight()
                }
                
            } label: {
                iconRightImage
                    .font(.ewHeadline)
                    .foregroundColor(.ewPrimaryBase)
            }
            
        }
        .overlay(
            Text(title)
                .font(.ewHeadline)
        )
    }
}

struct EWNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        EWNavigationBar()
    }
}
