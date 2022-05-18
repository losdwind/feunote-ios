//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: MIT-0
//

import SwiftUI

struct Loader: View {

    @State var animate = false
    var description: String

    var body: some View {
        VStack {
            withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [.primary]),
                                            center: .center),
                            style: StrokeStyle(lineWidth: 3,
                                               lineCap: .round))
                    .frame(width: 24, height: 24)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
            }
            
            Text(description)
                .bold()
        }.onAppear {
            self.animate = true
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader(description: "Loading")
    }
}
