import Foundation

public extension Encodable {
    var dictionary: [String: (any CustomStringConvertible)?] {
        (
            try? JSONSerialization.jsonObject(
                with: JSONEncoder().encode(self)
            )
        ) as? [String: (any CustomStringConvertible)?] ?? [:]
    }
}
