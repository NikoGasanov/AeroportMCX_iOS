
import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    @Binding var selectedTab: Int // Синхронизируем вкладки Прилеты/Вылеты
    @Binding var isSearching: Bool // Управляет поиском

    var body: some View {
        VStack(spacing: 0) {
            // Контейнер для списка рейсов
            ZStack {
                if viewModel.filteredFlights(for: selectedTab).isEmpty {
                    Text("По вашему запросу ничего не найдено")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.filteredFlights(for: selectedTab)) { flight in
                        NavigationLink(
                            destination: FlightDetailView(flight: flight, isDeparture: selectedTab == 0)
                        ) {
                            FlightRow(flight: flight)
                        }
                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
        }
        .onChange(of: selectedTab) { _ in
            // Закрывает поиск при смене вкладки
            withAnimation {
                isSearching = false
                viewModel.searchText = ""
                UIApplication.shared.endEditing()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
