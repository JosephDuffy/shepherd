import XCTest
import Shepherd

final class SynchronousClosurePathHandlerTests: XCTestCase {

    func testClosurePathHandlerWithDifferentPathType() {
        let router = Router()
        let path = "test-path"

        let intPathHandlerExpectation = XCTestExpectation(description: "Ask Int handler to handle path")
        intPathHandlerExpectation.isInverted = true
        router.addHandlerForPaths(ofType: Int.self, priority: .low) { _ in
            intPathHandlerExpectation.fulfill()
            return false
        }

        let handlePathCompletionHandlerExpectation = XCTestExpectation(description: "Call completion handler")
        router.handle(path: path) { handledRouter in
            handlePathCompletionHandlerExpectation.fulfill()

            XCTAssertNil(handledRouter, "Path should not be handled")
        }

        wait(
            for: [
                intPathHandlerExpectation,
                handlePathCompletionHandlerExpectation,
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    func testClosurePathHandlerNotHandlingPath() {
        let router = Router()
        let path = "test-path"

        let pathHandlerExpectation = XCTestExpectation(description: "Ask String handler to handle path")
        router.addHandlerForPaths(ofType: String.self, priority: .low) { _ in
            pathHandlerExpectation.fulfill()
            return false
        }

        let handlePathCompletionHandlerExpectation = XCTestExpectation(description: "Call completion handler")
        router.handle(path: path) { handledRouter in
            handlePathCompletionHandlerExpectation.fulfill()

            XCTAssertNil(handledRouter, "Path should not be handled")
        }

        wait(
            for: [
                pathHandlerExpectation,
                handlePathCompletionHandlerExpectation,
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    func testClosurePathHandlerHandlingPath() {
        let router = Router()
        let path = "test-path"

        let pathHandlerExpectation = XCTestExpectation(description: "Ask String handler to handle path")
        let pathHandler = router.addHandlerForPaths(ofType: String.self, priority: .low) { _ in
            pathHandlerExpectation.fulfill()
            return true
        }

        let handlePathCompletionHandlerExpectation = XCTestExpectation(description: "Call completion handler")
        router.handle(path: path) { handledRouter in
            handlePathCompletionHandlerExpectation.fulfill()

            XCTAssert(handledRouter === pathHandler, "Path should not be handled")
        }

        wait(
            for: [
                pathHandlerExpectation,
                handlePathCompletionHandlerExpectation,
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

}
