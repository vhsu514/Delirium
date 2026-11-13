import SwiftUI

/// Stage 1 shell for each of the six screens. Later stages replace the
/// placeholder body with the real content for each screen.
struct ScreenView: View {
    let screen: Screen
    let showNurse: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if screen == .nurse {
                    Text("nurse.topline")
                        .font(.title3.bold())
                        .accessibilityIdentifier("nurse.topline")
                }
                Text("placeholder.body")
                    .font(.body)
                    .accessibilityIdentifier("screen." + screen.rawValue + ".body")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .navigationTitle(Text(screen.titleKey))
        .safeAreaInset(edge: .bottom) {
            // The nurse page is the destination, so it does not link to itself.
            if screen != .nurse {
                ShowNurseButton(action: showNurse)
            }
        }
    }
}

/// Design rule: a "Show the nurse" button appears on every screen.
struct ShowNurseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("nurse.show", systemImage: "doc.text")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 56)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color("NurseBar"))
                )
        }
        .buttonStyle(PressFeedbackStyle())
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.bar)
        .accessibilityIdentifier("nurse.show")
    }
}
