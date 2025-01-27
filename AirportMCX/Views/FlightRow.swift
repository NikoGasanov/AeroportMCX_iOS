import SwiftUI

//struct FlightRow: View {
//    let flight: Flight
//
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(flight.flightNumber)
//                        .font(.headline)
//                    Text(flight.destination)
//                        .font(.subheadline)
//                    Text("Терминал: \(flight.terminal ?? "не указан")") // Добавляем отображение терминала
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                VStack(alignment: .trailing) {
//                    Text(flight.time)
//                        .font(.headline)
//                    Text(flight.status)
//                        .font(.subheadline)
//                        .foregroundColor(statusColor(for: flight.status))
//                }
//            }
//            .padding()
//
//            Rectangle()
//                .fill(Color.gray.opacity(0.5))
//                .frame(height: 1)
//                .padding(.leading, 16)
//        }
//        .background(Color(UIColor.systemBackground))
//        .cornerRadius(8)
//        .shadow(radius: 2)
//    }
//
//    private func statusColor(for status: String) -> Color {
//        switch status {
//        case "Вылетел", "Прибыл", "Регистрация":
//            return .green
//        case "Задержан":
//            return .yellow
//        case "Отменен":
//            return .red
//        case "Посадка":
//            return .blue
//        default:
//            return .black
//        }
//    }
//}


import SwiftUI

struct FlightRow: View {
    let flight: Flight

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flight.flightNumber)
                    .font(.headline)
                Text(flight.destination)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                // Отображение времени
                if let actualTime = flight.actualTime {
                    // Если рейс задержан
                    HStack(spacing: 4) {
                        Text(flight.scheduledTime)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .strikethrough() // Зачеркнутое запланированное время

                        Text(actualTime)
                            .font(.headline)
                            .foregroundColor(.red) // Новое время выделено красным
                    }
                } else {
                    // Если рейс по расписанию
                    Text(flight.scheduledTime)
                        .font(.headline)
                        .foregroundColor(.primary)
                }

                Text(flight.status)
                    .font(.subheadline)
                    .foregroundColor(statusColor(for: flight.status))
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
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
