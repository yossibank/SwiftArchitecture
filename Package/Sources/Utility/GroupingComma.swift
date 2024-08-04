import Foundation

public enum GroupingComma {
    private static let formatter: NumberFormatter = {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.groupingSeparator = ","
        format.groupingSize = 3
        return format
    }()

    public static func value(_ value: Any) -> String {
        let from = switch value {
        case let integer as Int:
            NSNumber(value: integer)

        case let double as Double:
            NSNumber(value: double)

        default:
            NSNumber()
        }

        return (formatter.string(from: from) ?? "---") + "円"
    }
}
