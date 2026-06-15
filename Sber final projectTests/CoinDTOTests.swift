import Foundation
import Testing
@testable import Sber_final_project

struct CoinDTOTests {
    @Test("Decodes a full CoinGecko-style payload into CoinDTO")
    func decodesFullPayload() throws {
        let json = #"""
        [
          {
            "id": "bitcoin",
            "symbol": "btc",
            "name": "Bitcoin",
            "image": "https://example.com/btc.png",
            "current_price": 67250.42,
            "market_cap": 1325000000000,
            "price_change_percentage_24h": 1.85
          }
        ]
        """#

        let data = Data(json.utf8)
        let dtos = try JSONDecoder().decode([CoinDTO].self, from: data)

        try #require(dtos.count == 1)
        let dto = dtos[0]
        #expect(dto.id == "bitcoin")
        #expect(dto.symbol == "btc")
        #expect(dto.name == "Bitcoin")
        #expect(dto.image == "https://example.com/btc.png")
        #expect(dto.currentPrice == 67250.42)
        #expect(dto.marketCap == 1_325_000_000_000)
        #expect(dto.priceChangePercentage24h == 1.85)
    }

    @Test("Decodes a payload with missing optional fields")
    func decodesPayloadWithMissingOptionals() throws {
        let json = #"""
        [
          {
            "id": "newcoin",
            "symbol": "new",
            "name": "New Coin",
            "current_price": 0.001
          }
        ]
        """#

        let data = Data(json.utf8)
        let dtos = try JSONDecoder().decode([CoinDTO].self, from: data)

        try #require(dtos.count == 1)
        let dto = dtos[0]
        #expect(dto.id == "newcoin")
        #expect(dto.image == nil)
        #expect(dto.marketCap == nil)
        #expect(dto.priceChangePercentage24h == nil)
        #expect(dto.currentPrice == 0.001)
    }

    @Test("toDomain maps DTO to a domain Coin with uppercased symbol")
    func mapsToDomain() throws {
        let dto = CoinDTO(
            id: "ethereum",
            symbol: "eth",
            name: "Ethereum",
            image: "https://example.com/eth.png",
            currentPrice: 3520.18,
            marketCap: 422_000_000_000,
            priceChangePercentage24h: -0.74
        )

        let coin = dto.toDomain()
        #expect(coin.id == "ethereum")
        #expect(coin.symbol == "ETH")
        #expect(coin.name == "Ethereum")
        #expect(coin.imageURL?.absoluteString == "https://example.com/eth.png")
        #expect(coin.currentPrice == 3520.18)
        #expect(coin.marketCap == 422_000_000_000)
        #expect(coin.priceChangePercentage24h == -0.74)
    }

    @Test("Bundled coins.json sample is decodable")
    func bundledSampleIsDecodable() throws {
        let json = #"""
        [
          {
            "id": "tether",
            "symbol": "usdt",
            "name": "Tether",
            "image": "https://example.com/usdt.png",
            "current_price": 1.0001,
            "market_cap": 112000000000,
            "price_change_percentage_24h": 0.01
          },
          {
            "id": "solana",
            "symbol": "sol",
            "name": "Solana",
            "image": "https://example.com/sol.png",
            "current_price": 142.77,
            "market_cap": 65000000000,
            "price_change_percentage_24h": 3.45
          }
        ]
        """#

        let data = Data(json.utf8)
        let dtos = try JSONDecoder().decode([CoinDTO].self, from: data)
        #expect(dtos.count == 2)
        #expect(dtos.map(\.id) == ["tether", "solana"])
    }

    @Test("Throws on malformed JSON")
    func throwsOnMalformed() {
        let json = #"""
        [
          {
            "id": "x",
            "symbol": "x"
          }
        ]
        """#
        let data = Data(json.utf8)
        #expect(throws: DecodingError.self) {
            _ = try JSONDecoder().decode([CoinDTO].self, from: data)
        }
    }
}
