//
//  NavigatorsBottom.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

struct EWNavigatorBottom: View {
    @State var index: Int
    var icons: [String]
    // var text : [String]? = [""]

    var body: some View {
        GeometryReader { g in
            HStack(spacing: 0) {
                self.makeTabs(totalWidth: g.size.width)
            }
        }.frame(height: 56)
    }

    func makeTabs(totalWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(0 ..< icons.count) { i in

                Button(action: { self.index = i }, label: {
                    VStack {
                        Rectangle().frame(height: 4).foregroundColor(self.index == i ? Color.ewPrimaryBase : Color.clear)
                        Image(systemName: self.icons[i])
                            .ewSquare(width: self.index == i ? 24 : 21)
                            .foregroundColor(self.index == i ? Color.ewPrimaryBase : Color.ewGray100)
                            .padding(.bottom, 24)
                            .padding(.top, 10)
                    }
                    .background(Color.ewGray50)
                    .frame(width: totalWidth / CGFloat(self.icons.count))
                    .animation(.easeOut(duration: 0.35))
                })
            }
        }
    }
}

struct EWNavigatorBottom_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack { Color.ewPrimaryBase.opacity(0.4) }

            EWNavigatorBottom(index: 0, icons: ["house.fill", "magnifyingglass", "heart.fill", "person.fill"])
        }
        .edgesIgnoringSafeArea(.all)
    }
}
