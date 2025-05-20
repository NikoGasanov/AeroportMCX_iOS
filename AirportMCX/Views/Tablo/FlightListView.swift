import SwiftUI

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    @Binding var selectedTab: Int      // 0 — вылеты, 1 — прилёты

    var body: some View {
        VStack(spacing: 0) {
            let flights = viewModel.filteredFlights(for: selectedTab)

            if flights.isEmpty {
                Text("По вашему запросу ничего не найдено")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(flights) { flight in
                    NavigationLink(
                        destination: FlightDetailView(
                            flight: flight,
                            isDeparture: selectedTab == 0
                        )
                    ) {
                        FlightRow(flight: flight)
                    }
                    .listRowInsets(
                        EdgeInsets(top: 10, leading: 16,
                                   bottom: 10, trailing: 16)
                    )
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await viewModel.reloadFlights()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
