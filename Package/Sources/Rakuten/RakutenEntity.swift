import APIClient

// https://webservice.rakuten.co.jp/documentation/ichiba-item-search

public struct RakutenEntity: DataStructure {
    /// [商品情報]
    public let items: [RakutenItem]
    /// [検索数]検索結果の総商品数
    public let count: Int
    /// [ページ番号]現在のページ番号
    public let page: Int
    /// [ページ内商品始追番]検索結果の何件目からか
    public let first: Int
    /// [ページ内商品終追番]検索結果の何件目までか
    public let last: Int
    /// [ヒット件数番] 1度に返却する商品数
    public let hits: Int
    /// [キャリア情報] PC=0 mobile=1 smartphone=2
    public let carrier: Int
    /// [総ページ数] 最大100
    public let pageCount: Int

    public struct RakutenItem: DataStructure, Hashable {
        /// [商品名] 従来の商品名は「catchCopy + itemName」で表示される
        public let itemName: String
        /// [キャッチコピー] 従来の商品名は「catchCopy + itemName」で表示される
        public let catchcopy: String
        /// [商品コード]
        public let itemCode: String
        /// [商品価格]
        public let itemPrice: Int
        /// [商品説明文]
        public let itemCaption: String
        /// [商品URL] httpsではじまる商品のURL
        public let itemUrl: String
        /// [商品画像64×64URL] 最大3枚のhttpsではじまる商品画像の配列
        public let smallImageUrls: [String]
        /// [商品画像128×128URL] 最大3枚のhttpsではじまる商品画像の配列
        public let mediumImageUrls: [String]
    }
}
