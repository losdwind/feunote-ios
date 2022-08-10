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
                    withAnimation(.linear) {
                        option = tab
                    }
                } label: {
                    HStack {

                        switch tab {
                        case .MOMENTS:
                            Image("macro")
                        case .EVENTS:
                            Image("check")
                        case .PERSONS:
                            Image("user")
                        case .BRANCHES:
                            Image("layers")
                        case .All:
                            Image("square")
                        }
                            if option == tab {
                                Text(tab.rawValue.localizedCapitalized).font(.ewHeadline)
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

struct EWSelector2: View {
    @Binding var option: CommunityTab
    @Binding var isPresentLocationPicker: Bool
    @Binding var location: WorldCityJsonReader.N?
    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
            ForEach(CommunityTab.allCases, id: \.self) { tab in
                if tab == CommunityTab.Local {
                    if option == tab {
                        EWButton(text: location?.c.localizedCapitalized ?? "Beijing", image: Image("arrow-down-1"), style: .primaryCapsule, action: { isPresentLocationPicker.toggle()

                        })
                    } else {
                        EWButton(text: location?.c.localizedCapitalized ?? "Beijing", image: nil, style: .secondaryCapsule, action: { withAnimation(.easeInOut) {
                            option = tab
                        }})
                    }

                } else {
                    EWButton(text: tab.rawValue.localizedCapitalized, image: nil, style: option == tab ? .primaryCapsule : .secondaryCapsule, action: { withAnimation(.easeInOut) {
                        option = tab
                    }})
                }
            }
        }
    }
}

struct EWSelector3: View {
    @Binding var option: CommunityTab
    @Binding var isPresentLocationPicker: Bool
    @Binding var location: WorldCityJsonReader.N?
    var body: some View {
        HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
            ForEach(CommunityTab.allCases, id: \.self) { tab in
                if tab == CommunityTab.Local {
                    if option == tab {
                        Button {
                            isPresentLocationPicker.toggle()
                        } label: {
                            HStack {
                                Text(location?.c.localizedCapitalized ?? "Beijing")
                                    .font(.ewHeadline)
                                    .foregroundColor(.ewBlack)
                                Image("chevron.down")
                                    .foregroundColor(.ewBlack)
                            }
                        }

                    } else {
                        Button {
                            withAnimation(.easeInOut) {
                                option = tab
                            }
                        } label: {
                            Text(location?.c.localizedCapitalized ?? "Beijing")
                                .font(.ewHeadline)
                                .foregroundColor(.ewGray100)
                        }
                    }

                } else {
                    Button {
                        withAnimation(.easeInOut) {
                            option = tab
                        }
                    } label: {
                        Text(tab.rawValue.localizedCapitalized)
                            .font(.ewHeadline)
                            .foregroundColor(option == tab ? .ewBlack : .ewGray100)
                    }
                }
            }
        }
    }
}

struct Selector_Previews: PreviewProvider {
    @State static var option = TimelineTab.MOMENTS
    @State static var option2 = CommunityTab.Sub
    @State static var showLocationPicker = false
    @State static var location: WorldCityJsonReader.N?
    static var previews: some View {
        EWSelector(option: $option)
            .previewLayout(.sizeThatFits)
        EWSelector2(option: $option2, isPresentLocationPicker: $showLocationPicker, location: $location)
    }
}
