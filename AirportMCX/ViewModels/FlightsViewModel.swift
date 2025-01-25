import Foundation

class FlightsViewModel: ObservableObject {
    @Published var arrivals: [Flight] = []
    @Published var departures: [Flight] = []
    @Published var searchText: String = "" {
        didSet {
            // Обновляем фильтрованные данные
            objectWillChange.send()
        }
    }

    init() {
        loadPlaceholderData()
    }

    func loadPlaceholderData() {
        arrivals = [
            Flight(flightNumber: "MCX321", destination: "Paris", time: "8:20", status: "Вылетел", terminal: "A"),
            Flight(flightNumber: "MCX654", destination: "Berlin", time: "8:45", status: "Вылетел", terminal: "A"),
            Flight(flightNumber: "MCX987", destination: "Tokyo", time: "9:20", status: "Вылетел", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "10:15", status: "Отменен", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "10:25", status: "Задерживается", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "11:15", status: "Посадка", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Регистрация", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Регистрация", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Регистрация", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Регистрация", terminal: "A")
            
        ]

        departures = [
            
            Flight(flightNumber: "MCX123", destination: "Moscow", time: "12:30", status: "Регистрация", terminal: "A"),
            Flight(flightNumber: "MCX456", destination: "Dubai", time: "14:00", status: "Задерживается", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Mackhachkala", time: "16:15", status: "Прибыл", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Прибыл", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Прибыл", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Прибыл", terminal: "A"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "Прибыл", terminal: "A")
        
        ]
    }

    func filteredFlights(for tab: Int) -> [Flight] {                   //  Функция для поиска по Городу, Номеру рейса
        let flights = tab == 0 ? arrivals : departures
        if searchText.isEmpty {
            return flights
        } else {
            return flights.filter {
                $0.flightNumber.lowercased().contains(searchText.lowercased()) ||
                $0.destination.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
