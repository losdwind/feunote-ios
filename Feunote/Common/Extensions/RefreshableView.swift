//
//  RefreshableView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/2.
//

import SwiftUI

struct RefreshableContentView: View {
    var body: some View {
        ScrollView {
            RefreshableView {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red).frame(height: 100).padding()
                    .overlay(Text("Button"))
                    .foregroundColor(.white)
            }
        }
        .refreshable { // << injects environment value !!
            await fetchSomething()
        }
    }

    func fetchSomething() async {
        // demo, assume we update something long here
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    }
}

struct RefreshableContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RefreshableView<Content: View>: View {
    var content: () -> Content

    @Environment(\.refresh) private var refresh // << refreshable injected !!
    @State private var isRefreshing = false

    var body: some View {
        VStack(alignment: .center, spacing: .ewPaddingVerticalLarge) {
            if isRefreshing {
                MyProgress() // ProgressView() ?? - no, it's boring :)
                    .transition(.scale)
            }
            content()
        }
        .animation(.default, value: isRefreshing)
        .background(GeometryReader {
            // detect Pull-to-refresh
            Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
        })
        .onPreferenceChange(ViewOffsetKey.self) {
            if $0 < -80, !isRefreshing { // << any creteria we want !!
                isRefreshing = true
                Task {
                    await refresh?() // << call refreshable !!
                    await MainActor.run {
                        isRefreshing = false
                    }
                }
            }
        }
    }
}

struct MyProgress: View {
    @State private var isProgress = false
    var body: some View {
        HStack {
            ForEach(0 ... 4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.red)
                    .scaleEffect(self.isProgress ? 1 : 0.01)
                    .animation(self.isProgress ? Animation.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)) :
                        .default,
                        value: isProgress)
            }
        }
        .onAppear { isProgress = true }
        .padding()
    }
}

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
