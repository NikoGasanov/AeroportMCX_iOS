import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    @Binding var selectedTab: Int   // 0 = Вылеты, 1 = Прилеты
    @Binding var isSearching: Bool

    var body: some View {
        VStack(spacing: 0) {
            let flights = viewModel.filteredFlights(for: selectedTab)

            if flights.isEmpty {
                Text("По вашему запросу ничего не найдено")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Явно вертикальный скролл
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(Array(flights.enumerated()), id: \.element.id) { index, flight in
                            VStack(spacing: 0) {
                                NavigationLink(
                                    destination: FlightDetailView(
                                        flight: flight,
                                        isDeparture: selectedTab == 0
                                    )
                                ) {
                                    FlightRow(flight: flight)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(PlainButtonStyle())

                                // рисуем разделитель, кроме последней карточки
                                if index < flights.count - 1 {
                                    Divider()
                                        .background(Color.gray)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .refreshable {
                        await viewModel.reloadFlights()
                    }
                }
                // ! Никаких .gesture или .simultaneousGesture — вертикальный ScrollView
                //   больше не перехватывает горизонтальные свайпы.
            }
        }
        .onChange(of: selectedTab) { _ in
            withAnimation {
                isSearching = false
                viewModel.searchText = ""
                UIApplication.shared.endEditing()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

