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
            Flight(
                    flightNumber: "SU123",
                    destination: "Москва",
                    status: "Задержан",
                    scheduledTime: "12:30",
                    actualTime: "14:00", // Рейс задержан
                    terminal: "B",
                    checkInDesk: "12",
                    gate: "B23",
                    airline: "Аэрофлот",
                    aircraft: "Boeing 737"
                ),
                Flight(
                    flightNumber: "SU456",
                    destination: "Дубай",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "A",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "FlyDubai",
                    aircraft: "Airbus A320"
                )
            
        ]

        departures = [
            
            Flight(
                    flightNumber: "SU123",
                    destination: "Москва",
                    status: "Задержан",
                    scheduledTime: "12:30",
                    actualTime: "14:00", // Рейс задержан
                    terminal: "B",
                    checkInDesk: "12",
                    gate: "B23",
                    airline: "Аэрофлот",
                    aircraft: "Boeing 737"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Дубай",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "A",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "FlyDubai",
                    aircraft: "Airbus A320"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                ),
            Flight(
                    flightNumber: "SU456",
                    destination: "Санкт-Петербург",
                    status: "По расписанию",
                    scheduledTime: "14:00",
                    actualTime: nil, // Рейс по расписанию
                    terminal: "B",
                    checkInDesk: "15",
                    gate: "C1",
                    airline: "Аэрофлот",
                    aircraft: "Boeng 777"
                )
        
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
