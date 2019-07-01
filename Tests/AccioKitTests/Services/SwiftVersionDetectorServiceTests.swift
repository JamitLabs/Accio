@testable import AccioKit
import XCTest

class SwiftVersionDetectorServiceTests: XCTestCase {
    func testGetCurrentSwiftVersion() {
        XCTAssertNoThrow(try SwiftVersionDetectorService.shared.getCurrentSwiftVersion())
    }

    func testConvertToSwiftVersion() {
        typealias Test = (parsingShouldSucceed: Bool, swiftVersionOutput: String, expectedSwiftVersion: String)
        let tests: [Test] = [
            Test(
                parsingShouldSucceed: true,
                swiftVersionOutput: """
                    Apple Swift version 5.1 (swiftlang-1100.0.43.3 clang-1100.0.26.3)
                    Target: x86_64-apple-darwin18.6.0
                """,
                expectedSwiftVersion: "Swift-5.1"
            ),
            Test(
                parsingShouldSucceed: true,
                swiftVersionOutput: """
                    Apple Swift version 5.0.1 (swiftlang-1001.0.82.4 clang-1001.0.46.5)
                    Target: x86_64-apple-darwin18.6.0
                """,
                expectedSwiftVersion: "Swift-5.0.1"
            ),
            Test(
                parsingShouldSucceed: true,
                swiftVersionOutput: """
                    Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
                    Target: x86_64-apple-darwin18.6.0
                """,
                expectedSwiftVersion: "Swift-4.2.1"
            ),
            Test(
                parsingShouldSucceed: false,
                swiftVersionOutput: """
                    Apple Swift version 4.2.1
                """,
                expectedSwiftVersion: ""
            ),
            Test(
                parsingShouldSucceed: false,
                swiftVersionOutput: """
                    Apple Swift Version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
                    Target: x86_64-apple-darwin18.6.0
                """,
                expectedSwiftVersion: ""
            ),
        ]

        for test in tests {
            guard test.parsingShouldSucceed else {
                XCTAssertThrowsError(
                    try SwiftVersionDetectorService.shared.convertToSwiftVersion(
                        swiftVersionOutput: test.swiftVersionOutput
                    )
                )
                continue
            }

            do {
                let parsedSwiftVersion = try SwiftVersionDetectorService.shared.convertToSwiftVersion(
                    swiftVersionOutput: test.swiftVersionOutput
                )

                XCTAssertEqual(parsedSwiftVersion, test.expectedSwiftVersion)
            }
            catch {
                XCTFail("convertToSwiftVersion(swiftVersionOutput:) unexpectedly throwed")
            }
        }
    }
}
