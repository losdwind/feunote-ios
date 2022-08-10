//
//  DoubleBarGraphView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/31.
//

import SwiftUI

struct TodoCompletionGraphView: View {
    var downloads: [Download]
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack(spacing: 10) {
                    Capsule()
                        .fill(Color.ewSecondary500)
                        .frame(width: 20, height: 8)

                    Text("Remained")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)

                    Capsule()
                        .fill(Color.ewPrimary500)
                        .frame(width: 20, height: 8)
                    Text("Completed")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Graph View
                GraphView()
            }

            .padding(.vertical, .ewPaddingVerticalDefault)
            .padding(.horizontal, .ewPaddingHorizontalDefault)
            .background(Color.ewGray50)
            .cornerRadius(.ewCornerRadiusDefault)
        }
    }

    @ViewBuilder
    func GraphView() -> some View {
        GeometryReader { proxy in

            ZStack {
                VStack(spacing: 0) {
                    ForEach(getGraphLines(), id: \.self) { line in

                        HStack(spacing: 8) {
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)

                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        // Removing the text size...
                        .offset(y: -15)
                    }
                }

                HStack {
                    ForEach(downloads) { download in

                        VStack(spacing: 0) {
                            VStack(spacing: 5) {
                                Capsule()
                                    .fill(Color.ewSecondary500)
                                Capsule()
                                    .fill(Color.ewPrimary500)
                            }
                            .frame(width: 8)
                            .frame(height: getBarHeight(point: download.downloads, size: proxy.size))

                            Text(download.weekDay)
                                .font(.caption)
                                .frame(height: 25, alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Fixed Height
        .frame(height: 190)
    }

    func getBarHeight(point: CGFloat, size: CGSize) -> CGFloat {
        let max = getMax()

        // 25 Text Height
        // 5 Spacing..
        let height = (point / max) * (size.height - 37)

        return height
    }

    // getting Sample Graph Lines based on max Value...
    func getGraphLines() -> [CGFloat] {
        let max = getMax()

        var lines: [CGFloat] = []

        lines.append(max)

        for index in 1 ... 4 {
            // dividing the max by 4 and iterating as index for graph lines...
            let progress = max / 4

            lines.append(max - (progress * CGFloat(index)))
        }

        return lines
    }

    // Getting Max....
    func getMax() -> CGFloat {
        let max = downloads.max { first, scnd in
            scnd.downloads > first.downloads
        }?.downloads ?? 0

        return max
    }
}

struct DoubleBarGraph_Previews: PreviewProvider {
    static var downloads: [Download] = [
        Download(downloads: 500, weekDay: "Mon"),
        Download(downloads: 240, weekDay: "Tue"),
        Download(downloads: 350, weekDay: "Wed"),
        Download(downloads: 430, weekDay: "Thu"),
        Download(downloads: 690, weekDay: "Fri"),
        Download(downloads: 540, weekDay: "Sat"),
        Download(downloads: 920, weekDay: "Sun"),
    ]
    static var previews: some View {
        TodoCompletionGraphView(downloads: downloads)
            .padding()
    }
}
