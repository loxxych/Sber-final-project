import Foundation
import SwiftData

@Model
final class FavoriteCoinModel {
    @Attribute(.unique) var id: String
    var symbol: String
    var name: String
    var imageURLString: String?
    var currentPrice: Double
    var marketCap: Double?
    var priceChangePercentage24h: Double?
    var addedAt: Date

    init(
        id: String,
        symbol: String,
        name: String,
        imageURLString: String?,
        currentPrice: Double,
        marketCap: Double?,
        priceChangePercentage24h: Double?,
        addedAt: Date = .init()
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.imageURLString = imageURLString
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.priceChangePercentage24h = priceChangePercentage24h
        self.addedAt = addedAt
    }
}

extension FavoriteCoinModel {
    var toDomain: Coin {
        Coin(
            id: id,
            symbol: symbol,
            name: name,
            imageURL: imageURLString.flatMap(URL.init(string:)),
            currentPrice: currentPrice,
            marketCap: marketCap,
            priceChangePercentage24h: priceChangePercentage24h
        )
    }

    static func make(from coin: Coin) -> FavoriteCoinModel {
        FavoriteCoinModel(
            id: coin.id,
            symbol: coin.symbol,
            name: coin.name,
            imageURLString: coin.imageURL?.absoluteString,
            currentPrice: coin.currentPrice,
            marketCap: coin.marketCap,
            priceChangePercentage24h: coin.priceChangePercentage24h
        )
    }
}
