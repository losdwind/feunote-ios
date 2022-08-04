//
//  TodoCompletionStatsView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/2.
//

import SwiftUI

struct TodoCompletionStatsView: View {
    var progress: Double
    var totalNumOfTasksThisWeek: Int
    var totalNumOfTasksThisWeekIncremental: Int
    var overduedNumOfTasksThisWeek: Int
    var overduedNumOfTasksThisWeekIncremental: Int
    var ongoingNumOfTasksThisWeek: Int
    var ongoingNumOfTasksThisWeekIncremental: Int

    var body: some View {
            HStack(alignment: .center, spacing: .ewPaddingHorizontalLarge) {
                // completion rate ring
                VStack(alignment: .center, spacing: .ewPaddingVerticalDefault) {
                    ZStack(alignment: .center) {
                        Text(String(format: "%.2f%%", progress*100))
                            .foregroundColor(.ewSecondaryBase)
                            .font(.ewFootnote)
                            .fontWeight(.semibold)
                        Circle()
                            .stroke(Color.ewSecondary100, lineWidth: 5)
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [.ewSecondaryBase]),
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)
                                ),
                                style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                    }
                    .frame(width: 70, height: 70, alignment: .center)

                    Text("Completion")
                        .font(.ewFootnote)
                        .foregroundColor(.ewGray900)
                }
                .layoutPriority(1)
                HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault){
                    // totoal task number tile
                    VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                        HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                            Text("\(totalNumOfTasksThisWeek)")
                                .font(.ewLargeTitle)
                            HStack(alignment: .center, spacing: 0) {
                                Image("arrow-up-1-1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8, height: 8, alignment: .center)
                                Text("\(totalNumOfTasksThisWeekIncremental)")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.ewSuccess)
                        }
                        Text("Tasks")
                            .font(.ewFootnote)
                    }

                    // totoal task overdued
                    VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                        HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                            Text("\(overduedNumOfTasksThisWeek)")
                                .font(.ewLargeTitle)
                            HStack(alignment: .center, spacing: 0) {
                                Image("arrow-down-2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8, height: 8, alignment: .center)
                                Text("\(overduedNumOfTasksThisWeekIncremental)")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.ewError)
                        }
                        Text("Overdue")
                            .font(.ewFootnote)
                    }

                    // totoal task ongoing
                    VStack(alignment: .leading, spacing: .ewPaddingVerticalSmall) {
                        HStack(alignment: .center, spacing: .ewPaddingHorizontalSmall) {
                            Text("\(ongoingNumOfTasksThisWeek)")
                                .font(.ewLargeTitle)
                            HStack(alignment: .center, spacing: 0) {
                                Image("arrow-down-2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8, height: 8, alignment: .center)
                                Text("\(ongoingNumOfTasksThisWeekIncremental)")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.ewError)
                        }
                        Text("Ongoing")
                            .font(.ewFootnote)
                    }
                }

            }
            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingHorizontalDefault)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)


    }
}

struct TodoCompletionStatsView_Previews: PreviewProvider {
    static var downloads = [

        Download(downloads: 5, weekDay: "Mon"),
        Download(downloads: 2, weekDay: "Tue"),
        Download(downloads: 3, weekDay: "Wed"),
        Download(downloads: 4, weekDay: "Thu"),
        Download(downloads: 6, weekDay: "Fri"),
        Download(downloads: 5, weekDay: "Sat"),
        Download(downloads: 9, weekDay: "Sun"),
    ]
    static var previews: some View {
        TodoCompletionStatsView(progress: 0.732, totalNumOfTasksThisWeek: 12, totalNumOfTasksThisWeekIncremental: 3, overduedNumOfTasksThisWeek: 4, overduedNumOfTasksThisWeekIncremental: 4,ongoingNumOfTasksThisWeek: 2, ongoingNumOfTasksThisWeekIncremental: 1)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
