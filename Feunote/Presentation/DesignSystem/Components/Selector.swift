//
//  Selector.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/24.
//

import SwiftUI

struct EWSelector: View {
    @Binding var option: TimelineTab

    var body: some View {
        HStack {
            ForEach(TimelineTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut) {
                        option = tab
                    }
                } label: {
                    HStack {
                        if option == tab {
                            Text(tab.rawValue.localizedCapitalized).font(.ewHeadline)
                        }
                        switch tab {
                        case .MOMENTS:
                            Image("macro")
                        case .EVENTS:
                            Image("check")
                        case .PERSONS:
                            Image("user")
                        case .BRANCHES:
                            Image("layers")
                        }
                    }
                    .foregroundColor(option == tab ? .ewGray900 : .ewGray100)
                    .padding(.vertical, option == tab ? .ewPaddingVerticalSmall : 0)
                    .padding(.horizontal, option == tab ? .ewPaddingVerticalDefault : 0)

                    .background(option == tab ? Color.ewPrimary100 : Color.ewWhite.opacity(1))
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct Selector_Previews: PreviewProvider {
    @State static var option = TimelineTab.MOMENTS
    static var previews: some View {
        EWSelector(option: $option)
            .previewLayout(.sizeThatFits)
    }
}
