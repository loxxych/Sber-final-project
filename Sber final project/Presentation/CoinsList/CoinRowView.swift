import SwiftUI

struct CoinRowView: View {
    let coin: Coin

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: coin.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Image(systemName: "bitcoinsign.circle")
                        .resizable()
                        .foregroundStyle(.secondary)
                default:
                    Color.gray.opacity(0.15)
                }
            }
            .frame(width: 36, height: 36)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(coin.name)
                    .font(.headline)
                Text(coin.symbol)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            Text(coin.currentPrice, format: .currency(code: "USD"))
                .font(.subheadline.monospacedDigit())
        }
        .padding(.vertical, 4)
    }
}
