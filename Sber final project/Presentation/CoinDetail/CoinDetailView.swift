import SwiftUI

struct CoinDetailView: View {
    @State private var viewModel: CoinDetailViewModel

    init(viewModel: @autoclosure @escaping () -> CoinDetailViewModel) {
        _viewModel = State(initialValue: viewModel())
    }

    var body: some View {
        VStack(spacing: 24) {
            AsyncImage(url: viewModel.coin.imageURL) { phase in
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
            .frame(width: 96, height: 96)
            .clipShape(Circle())

            VStack(spacing: 4) {
                Text(viewModel.coin.name)
                    .font(.title.bold())
                Text(viewModel.coin.symbol)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                detailRow(
                    title: "Цена",
                    value: viewModel.coin.currentPrice.formatted(.currency(code: "USD"))
                )
                if let marketCap = viewModel.coin.marketCap {
                    detailRow(
                        title: "Капитализация",
                        value: marketCap.formatted(.currency(code: "USD").precision(.fractionLength(0)))
                    )
                }
                if let change = viewModel.coin.priceChangePercentage24h {
                    detailRow(
                        title: "Изменение 24ч",
                        value: String(format: "%+.2f%%", change),
                        valueColor: change >= 0 ? .green : .red
                    )
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Spacer()

            Button {
                viewModel.toggleFavorite()
            } label: {
                Label(
                    viewModel.isFavorite ? "В избранном" : "Добавить в избранное",
                    systemImage: viewModel.isFavorite ? "star.fill" : "star"
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(viewModel.isFavorite ? .yellow : .accentColor)
        }
        .padding()
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.refreshFavoriteState() }
    }

    private func detailRow(title: String, value: String, valueColor: Color = .primary) -> some View {
        HStack {
            Text(title).foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(valueColor)
        }
    }
}
