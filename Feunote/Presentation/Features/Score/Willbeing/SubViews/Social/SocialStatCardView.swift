//
//  SocialStatCardView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/3.
//

import CryptoKit
import SwiftUI
extension Double {
    func doubleToString(isPercentage: Bool) -> String {
        if isPercentage {
            return String(format: "%.0f%%", self * 100)
        } else if Int(exactly: self) == nil {
            return String(format: "%.2f%", self)
        } else {
            return String(Int(exactly: self)!)
        }
    }
}

struct SocialStatCardView: View {
    var statResult: Double
    var statResultIncremental: Double
    var isPercentage: Bool
    var title: String
    var description: String

    var body: some View {
        // totoal task ongoing
        VStack(alignment: .center, spacing: .ewPaddingVerticalSmall) {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                Text(statResult.doubleToString(isPercentage: isPercentage))
                    .font(.ewLargeTitle)
                HStack(alignment: .center, spacing: 0) {
                    Image(statResultIncremental < 0 ? "arrow-down-2" : "arrow-up-1-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 8, height: 8, alignment: .center)
                    Text(statResultIncremental.doubleToString(isPercentage: isPercentage))
                        .font(.subheadline)
                }
                .foregroundColor(statResultIncremental < 0 ? .ewError : .ewSuccess)
            }
            Text(title)
                .font(.ewHeadline)
            Text(description)
                .lineLimit(2)
                .font(.ewFootnote)
                .foregroundColor(.ewGray900)
        }
    }
}

struct SocialStatCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SocialStatCardView(statResult: 4, statResultIncremental: 1, isPercentage: false, title: "New Friends", description: "No. of persons added")
            SocialStatCardView(statResult: 0.82, statResultIncremental: 0.12, isPercentage: true, title: "New Friends", description: "No. of persons added")
        }
    }
}
