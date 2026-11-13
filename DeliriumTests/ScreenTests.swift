import Testing
@testable import Delirium

struct ScreenTests {
    @Test func homeHasSixScreensInPlanOrder() {
        #expect(Screen.allCases == [.today, .check, .voices, .family, .nurse, .help])
    }

    @Test func homeNeverHasMoreThanSixItems() {
        #expect(Screen.allCases.count <= 6)
    }

    @Test func everyScreenHasASymbol() {
        for screen in Screen.allCases {
            #expect(!screen.symbolName.isEmpty)
        }
    }
}
