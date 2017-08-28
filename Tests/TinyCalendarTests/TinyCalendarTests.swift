import XCTest
@testable import TinyCalendar

class TinyCalendarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TinyCalendar().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
