import SwiftUI

struct FlightListView: View {
    @StateObject var viewModel = FlightsViewModel()
    let title: String

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Flight", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(viewModel.filteredFlights) { flight in
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRow(flight: flight)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}
