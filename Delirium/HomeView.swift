import SwiftUI

/// Home: six large buttons, one per screen.
struct HomeView: View {
    let open: (Screen) -> Void

    @Environment(\.dynamicTypeSize) private var typeSize

    /// Two columns normally, one column at accessibility text sizes so
    /// nothing clips.
    private var columns: [GridItem] {
        let item = GridItem(.flexible(), spacing: 16, alignment: .top)
        return typeSize.isAccessibilitySize ? [item] : [item, item]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Screen.allCases) { screen in
                    Button {
                        open(screen)
                    } label: {
                        HomeTile(screen: screen)
                    }
                    .buttonStyle(PressFeedbackStyle())
                    .accessibilityIdentifier("home." + screen.rawValue)
                }
            }
            .padding(16)
        }
        .navigationTitle(Text("home.title"))
    }
}

private struct HomeTile: View {
    let screen: Screen

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: screen.symbolName)
                .font(.title)
                .foregroundStyle(Color.accentColor)
                .accessibilityHidden(true)
            Text(screen.titleKey)
                .font(.title2.bold())
            Text(screen.subtitleKey)
                .font(.body)
        }
        .foregroundStyle(.primary)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .topLeading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

/// Design rule: every tap gives visible feedback.
struct PressFeedbackStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
