import SwiftUI

struct AppTheme {
    static let background = Color(red: 0.90, green: 0.95, blue: 0.97)

    static let primaryBlue = Color(
        red: 133/255,
        green: 172/255,
        blue: 205/255
    )

    static func gotu(_ size: CGFloat) -> Font {
        .custom("Gotu-Regular", size: size)
    }
}
