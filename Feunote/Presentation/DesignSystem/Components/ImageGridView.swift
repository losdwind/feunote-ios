//
//  ImageGridView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/16.
//

import Kingfisher
import SwiftUI
struct SingleImageView: View {
    let imageURL: String
    var body: some View {
        // 按照最大区域 180x180 等比缩放
        KFImage(URL(string: imageURL))
            .placeholder {
//                // Placeholder while downloading.
//                Image(systemName: "arrow.2.circlepath.circle")
//                    .font(.largeTitle)
//                    .opacity(0.3)
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 180, maxHeight: 180, alignment: .leading)
            .cornerRadius(18)
    }
}

// the variational version of SingleImageView which receiving UIImage data
struct SingleImageDataView: View {
    let uiImage: UIImage
    var body: some View {
        // 按照最大区域 180x180 等比缩放
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 180, maxHeight: 180, alignment: .leading)
            .cornerRadius(18)
    }
}

struct ImageGridView: View {
    let imageURLs: [String]

    var cols: Int { imageURLs.count == 4 ? 2 : min(imageURLs.count, 3) }
    var rows: Int { imageURLs.count / cols }
    var lastRowCols: Int { imageURLs.count % cols }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(0 ..< rows, id: \.self) { row in
                self.rowBody(row: row, isLast: false)
            }
            if lastRowCols > 0 {
                self.rowBody(row: rows, isLast: true)
            }
        }
    }

    func rowBody(row: Int, isLast: Bool) -> some View {
        HStack(spacing: 6) {
            ForEach(0 ..< (isLast ? self.lastRowCols : self.cols), id: \.self) { col in
                KFImage(URL(string: imageURLs[row * self.cols + col]))
                    .placeholder {
                        // Placeholder while downloading.
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 60, maxWidth: 80, minHeight: 60, maxHeight: 80)
                    .cornerRadius(10)
            }
        }
    }
}

struct ImageGridDataView: View {
    let images: [UIImage]

    var cols: Int { images.count == 4 ? 2 : min(images.count, 3) }
    var rows: Int { images.count / cols }
    var lastRowCols: Int { images.count % cols }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(0 ..< rows, id: \.self) { row in
                self.rowBody(row: row, isLast: false)
            }
            if lastRowCols > 0 {
                self.rowBody(row: rows, isLast: true)
            }
        }
    }

    func rowBody(row: Int, isLast: Bool) -> some View {
        HStack(spacing: 6) {
            ForEach(0 ..< (isLast ? self.lastRowCols : self.cols), id: \.self) { col in
                Image(uiImage: images[row * self.cols + col])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 60, maxWidth: 80, minHeight: 60, maxHeight: 80)
                    .aspectRatio(1, contentMode: .fill)
                    .cornerRadius(10)
            }
        }
    }
}

// struct SingleVideoView: View {
//    let videoURL:String
//
//    /// 控制开始播放 / 控制停止播放
//    @State private var play: Bool = false
//
//    /// 播放中 / 非播放状态（例如缓冲、错误、暂停等）
//    @State private var isPlaying: Bool = false
//
//
//
//    var body: some View {
//        ZStack {
//            VideoPlayer(url: URL(string: videoURL)!, play: $play)
//                .onStateChanged { state in
//                    switch state {
//                    case .playing:  self.isPlaying = true
//                    default:        self.isPlaying = false
//                    }
//                }
//            // 可见时播放，不可见时暂停
//                .onAppear { self.play = true }
//                .onDisappear { self.play = false }
//
//            // MARK: - here pending solved to show the video cover
//            //            if !isPlaying {
//            //                // 非播放状态下显示封面图
//            //                Image(video.cover!)
//            //                    .resizable()
//            //            }
//        }
//        // 按照最大区域 225x225 等比缩放
//        .aspectRatio(contentMode: .fit)
//        .frame(maxWidth: 225, maxHeight: 225, alignment: .leading)
//    }
// }

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(imageURLs: ["", "", ""])
    }
}
