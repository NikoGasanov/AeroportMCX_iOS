
import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    @Binding var selectedTab: Int
    @Binding var isSearching: Bool

    var body: some View {
        VStack(spacing: 0) {
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
                    // <-- Здесь добавляем pull-to-refresh
                    .refreshable {
                        // предположим, что ваш viewModel умеет перезагружать данные
                        await viewModel.reloadFlights()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
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
