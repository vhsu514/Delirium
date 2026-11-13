import XCTest

final class HomeUITests: XCTestCase {
    private let screens = ["today", "check", "voices", "family", "nurse", "help"]

    override func setUp() {
        continueAfterFailure = false
    }

    func testHomeShowsSixButtons() {
        let app = XCUIApplication()
        app.launch()
        for screen in screens {
            XCTAssertTrue(app.buttons["home." + screen].waitForExistence(timeout: 5), screen)
        }
    }

    func testEachButtonOpensItsScreenAndBackReturnsHome() {
        let app = XCUIApplication()
        app.launch()
        for screen in screens {
            app.buttons["home." + screen].tap()
            XCTAssertTrue(
                app.staticTexts["screen." + screen + ".body"].waitForExistence(timeout: 5), screen)
            app.navigationBars.buttons.element(boundBy: 0).tap()
            XCTAssertTrue(app.buttons["home.today"].waitForExistence(timeout: 5))
        }
    }

    func testShowTheNurseOpensNursePageOneTapFromHome() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["home.today"].tap()
        app.buttons["nurse.show"].tap()
        XCTAssertTrue(app.staticTexts["nurse.topline"].waitForExistence(timeout: 5))
        // The nurse page does not link to itself.
        XCTAssertFalse(app.buttons["nurse.show"].exists)
        // Back goes straight home, not to Today.
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["home.today"].waitForExistence(timeout: 5))
    }
}
