import SwiftUI

public extension View {
    /// Sets the style for `Chart` within the environment of `self`.
    func chartStyle<S>(_ style: S) -> some View where S: ChartStyle {
        environment(\.chartStyle, AnyChartStyle(style))
    }
}
