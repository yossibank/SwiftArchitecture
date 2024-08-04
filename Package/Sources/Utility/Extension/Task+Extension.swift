import Foundation

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds duration: TimeInterval) async throws {
        let delay = UInt64(duration * 1000 * 1000 * 1000)
        try await Task.sleep(nanoseconds: delay)
    }
}
