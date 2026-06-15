import Foundation

struct Coin: Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let imageURL: URL?
    let currentPrice: Double
    let marketCap: Double?
    let priceChangePercentage24h: Double?
}
