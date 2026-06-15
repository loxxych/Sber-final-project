import Foundation

struct CoinDTO: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String?
    let currentPrice: Double
    let marketCap: Double?
    let priceChangePercentage24h: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

extension CoinDTO {
    func toDomain() -> Coin {
        Coin(
            id: id,
            symbol: symbol.uppercased(),
            name: name,
            imageURL: image.flatMap(URL.init(string:)),
            currentPrice: currentPrice,
            marketCap: marketCap,
            priceChangePercentage24h: priceChangePercentage24h
        )
    }
}
