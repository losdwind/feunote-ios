//
//  ScoreComponentCard.swift
//  Feunote
//
//  Created by Losd wind on 2022/7/22.
//

import SwiftUI

struct ScoreComponentCard: View {
    var iconName: String
    var name: String
    var description: String
    var score: Double
    var fullScoreForEachComponent: Int = 200
    var color: Color = .ewPrimaryBase
    var body: some View {
        VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
            HStack(alignment: .center) {
                Label {
                    Text(name)
                        .font(.ewSubheadline)
                        .foregroundColor(.ewPrimaryBase)
                } icon: {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16, alignment: .center)
                        .opacity(0.5)
                }

                Spacer()
                VStack(alignment: .center, spacing: .ewPaddingVerticalSmall) {
                    Text(String(Int(score * Double(fullScoreForEachComponent))))
                        .font(.ewTitle2)
                        .foregroundColor(.ewSecondaryBase)

                    ZStack(alignment: .leading) {
                        Color.ewGray100
                            .frame(width: 100, height: 2)
                        Color.ewPrimaryBase
                            .frame(width: CGFloat(Int(score * 100)), height: 2)
                    }
                }
            }

            Text(description)
                .foregroundColor(.ewGray900)
                .font(.ewFootnote)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, .ewPaddingVerticalDefault)
        .padding(.horizontal, .ewPaddingHorizontalDefault)
        .background(Color.ewGray50, in: RoundedRectangle(cornerRadius: .ewPaddingVerticalDefault))
    }
}

struct ScoreComponentCard_Previews: PreviewProvider {
    static var previews: some View {
        ScoreComponentCard(iconName: "Briefcase", name: "Career", description: "Career metrics measure your completion rate of todos and job attributes.", score: 0.65, fullScoreForEachComponent: 200)
            .padding()
    }
}
