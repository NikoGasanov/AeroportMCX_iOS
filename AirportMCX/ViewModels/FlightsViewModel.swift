import Foundation

@MainActor
class FlightsViewModel: ObservableObject {
    @Published var arrivals:   [Flight] = []
    @Published var departures: [Flight] = []
    @Published var searchText  = ""
    @Published var isLoading   = false
    @Published var errorMessage: String?

    init() {
        Task { await reloadFlights() }      // первичная загрузка
    }

    // Вызывается при старте и pull-to-refresh
    func reloadFlights() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await FlightService.shared.fetchAll()
            arrivals   = result.arrivals
            departures = result.departures
        } catch {
            errorMessage = error.localizedDescription
            print("Ошибка загрузки рейсов:", error)
        }
        isLoading = false
    }

    // Фильтр по вкладке и текстовому поиску
    func filteredFlights(for tab: Int) -> [Flight] {
        let source = (tab == 0 ? arrivals : departures)
        guard !searchText.isEmpty else { return source }
        let query = searchText.lowercased()

        return source.filter {
            $0.flightNumber.lowercased().contains(query) ||
            $0.direction.lowercased().contains(query)    ||
            $0.airline.lowercased().contains(query)
        }
    }
}
