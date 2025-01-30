import SwiftUI

struct FlightDetailView: View {
    let flight: Flight // Данные рейса
    let isDeparture: Bool // Указывает, это вылет или прилет

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(isDeparture ? "Детали рейса (Вылет)" : "Детали рейса (Прилёт)")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Рейс: \(flight.flightNumber)")
                        .font(.headline)
                    Text("Пункт назначения: \(flight.destination)")
                        .font(.subheadline)

                    // Отображение времени
                    if let actualTime = flight.actualTime, actualTime != flight.scheduledTime {
                        HStack(spacing: 4) {
                            Text(flight.scheduledTime)
                                .strikethrough()
                                .foregroundColor(.gray)
                                .font(.subheadline)

                            Text(actualTime)
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                    } else {
                        Text(flight.scheduledTime)
                            .font(.headline)
                    }

                    Text("Статус: \(flight.status)")
                        .font(.subheadline)
                        .foregroundColor(statusColor(for: flight.status))

                    if let terminal = flight.terminal {
                        Text(isDeparture ? "Терминал: \(terminal)" : "Терминал прибытия: \(terminal)")
                            .font(.subheadline)
                    }

                    if let checkInDesk = flight.checkInDesk, isDeparture {
                        Text("Стойка регистрации: \(checkInDesk)")
                            .font(.subheadline)
                    }

                    if let gate = flight.gate, isDeparture {
                        Text("Выход на посадку: \(gate)")
                            .font(.subheadline)
                    }

                    Text("Авиакомпания: \(flight.airline)")
                        .font(.subheadline)
                    Text("Воздушное судно: \(flight.aircraft)")
                        .font(.subheadline)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .padding()
        }
        .navigationTitle("Информация о рейсе")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func statusColor(for status: String) -> Color {
        switch status {
        case "Вылетел", "Прибыл", "Регистрация":
            return .green
        case "Задержан":
            return .yellow
        case "Отменен":
            return .red
        case "Посадка":
            return .blue
        default:
            return .black
        }
    }
}
