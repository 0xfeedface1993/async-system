import Testing
@testable import AsyncSystem

#if COMBINE_LINUX && canImport(CombineX)
import CombineX
#else
import Combine
#endif

@Test func oneAsyncValue() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let value = #require(
        try await Future<String, Error> { promise in
            promise(.success("complete"))
        }.asyncValue
    )
    #expect(value == "complete")
}
