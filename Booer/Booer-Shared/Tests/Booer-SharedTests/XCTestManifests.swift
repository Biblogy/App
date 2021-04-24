import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Booer_SharedTests.allTests),
    ]
}
#endif
