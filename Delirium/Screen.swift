import SwiftUI

/// The six screens reachable from home, in the order they appear.
/// Design rule: no more than six items on the home screen.
enum Screen: String, CaseIterable, Identifiable, Hashable {
    case today, check, voices, family, nurse, help

    var id: String { rawValue }

    /// Strings catalog key for the screen title.
    var titleKeyName: String { "screen." + rawValue + ".title" }

    /// Strings catalog key for the short line under the title on home.
    var subtitleKeyName: String { "screen." + rawValue + ".subtitle" }

    var titleKey: LocalizedStringKey { LocalizedStringKey(titleKeyName) }
    var subtitleKey: LocalizedStringKey { LocalizedStringKey(subtitleKeyName) }

    /// SF Symbol shown on the home button. Decorative only.
    var symbolName: String {
        switch self {
        case .today: return "checklist"
        case .check: return "eye"
        case .voices: return "mic"
        case .family: return "person.2"
        case .nurse: return "doc.text"
        case .help: return "questionmark.circle"
        }
    }
}
