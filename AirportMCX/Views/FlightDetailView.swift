


import SwiftUI

struct FlightDetailView: View {
    let flight: Flight

    var body: some View {
        VStack(spacing: 20) {
            Text("Детали рейса")
                .font(.largeTitle)
                .bold()
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Рейс: \(flight.flightNumber)")
                    .font(.headline)
                Text("Пункт назначения: \(flight.destination)")
                    .font(.subheadline)
                Text("Время: \(flight.time)")
                    .font(.subheadline)
                Text("Статус: \(flight.status)")
                    .font(.subheadline)
                    .foregroundColor(statusColor(for: flight.status))
                Text("Терминал: \(flight.terminal)")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)

            Spacer()
        }
        .padding()
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
