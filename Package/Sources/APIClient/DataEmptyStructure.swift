/// 空パラメータ用
public struct EmptyParameters: Encodable, Equatable {
    public init() {}
}

/// 空レスポンス用
public struct EmptyAPIResponse: Codable, Equatable {
    public init() {}
}

/// 必要なしパス用
public struct EmptyPathComponent {
    public init() {}
}
