import SwiftUI

struct AnyChartStyle: ChartStyle {
    private let styleMakeBody: (ChartStyle.Configuration) -> AnyView

    init<S: ChartStyle>(_ style: S) {
        styleMakeBody = style.makeTypeErasedBody
    }

    func makeBody(configuration: ChartStyle.Configuration) -> AnyView {
        styleMakeBody(configuration)
    }
}

private extension ChartStyle {
    func makeTypeErasedBody(configuration: ChartStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
