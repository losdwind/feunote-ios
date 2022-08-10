import SwiftUI

struct ChartStyleKey: EnvironmentKey {
    static let defaultValue: AnyChartStyle = .init(LineChartStyle())
}
