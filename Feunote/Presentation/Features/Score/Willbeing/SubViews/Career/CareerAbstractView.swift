//
//  CareerAbstractView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/30.
//

import SwiftUI


struct Download: Identifiable{
    
    var id = UUID().uuidString
    var downloads: CGFloat
    var weekDay: String
}

struct CareerAbstractView: View {
    var downloads = [

        Download(downloads: 5, weekDay: "Mon"),
        Download(downloads: 2, weekDay: "Tue"),
        Download(downloads: 3, weekDay: "Wed"),
        Download(downloads: 4, weekDay: "Thu"),
        Download(downloads: 6, weekDay: "Fri"),
        Download(downloads: 5, weekDay: "Sat"),
        Download(downloads: 9, weekDay: "Sun"),
    ]

    @State var period = ChartPerid.Week

    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {

                // Todo Completion Rate
                VStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                    // title
                    ScoreTitleView(title: "Todo Completion", isShowingMenu: true, period:$period)

                    TodoCompletionStatsView(progress: 0.732, totalNumOfTasksThisWeek: 12, totalNumOfTasksThisWeekIncremental: 3, overduedNumOfTasksThisWeek: 4, overduedNumOfTasksThisWeekIncremental: 4,ongoingNumOfTasksThisWeek: 2, ongoingNumOfTasksThisWeekIncremental: 1)


                    TodoCompletionGraphView(downloads:downloads )
                }


            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("arrow-left-2")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.ewBlack)
                }

            }

        }

            .padding()
    }
}

struct CareerAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        CareerAbstractView()
    }
}
