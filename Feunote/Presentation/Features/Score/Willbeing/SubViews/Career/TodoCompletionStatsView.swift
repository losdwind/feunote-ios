//
//  TodoCompletionStatsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/2.
//

import SwiftUI

struct TodoCompletionStatsView: View {
    var body: some View {
        VStack{
            HStack{

                Text("Todo Completion Rate")
                    .font(.ewHeadline)

                Spacer()

                Menu {

                    Button("Month"){}
                    Button("Year"){}
                    Button("Day"){}

                } label: {
                    HStack(spacing: 4){

                        Text("this week")

                        Image(systemName: "arrowtriangle.down.fill")
                            .scaleEffect(0.7)
                    }
                    .font(.ewSubheadline)
                    .foregroundColor(.ewGray900)
                    .padding(.horizontal,.ewPaddingHorizontalDefault)
                    .padding(.vertical, .ewPaddingVerticalSmall)
                    .background(Color.ewGray50)
                    .cornerRadius(.ewCornerRadiusRound)
                }

            }

            HStack{
                Circle()
                    .stroke(.blue, lineWidth: 2)
                    .tint(.ewSecondary100)

            }
        }
    }
}

struct TodoCompletionStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCompletionStatsView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
