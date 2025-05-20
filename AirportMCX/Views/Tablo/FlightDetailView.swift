import SwiftUI

struct FlightDetailView: View {
    let flight: Flight          // Текущий рейс
    let isDeparture: Bool       // true = вылет, false = прилёт

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Заголовок
                Text(isDeparture ? "Детали рейса (Вылет)"
                                 : "Детали рейса (Прилёт)")
                    .font(.largeTitle).bold()
                    .padding(.top)

                // Основная карточка с информацией
                VStack(alignment: .leading, spacing: 12) {

                    Text("Рейс: \(flight.flightNumber)")
                        .font(.headline)

                    Text("Маршрут: \(flight.direction)")
                        .font(.subheadline)

                    // Время (план / факт)
                    timeSection

                    Text("Статус: \(flight.status)")
                        .foregroundColor(color(for: flight.status))

                    Text("Авиакомпания: \(flight.airline)")
                    Text("Воздушное судно: \(flight.aircraft)")

                    // Доп. поля, встречаются только у вылетов
                    if let start = flight.registrationStart {
                        Text("Начало регистрации: \(start)")
                    }
                    if let end = flight.registrationEnd {
                        Text("Окончание регистрации: \(end)")
                    }
                    if let board = flight.boardingEnd {
                        Text("Завершение посадки: \(board)")
                    }
                }
                .font(.subheadline)
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

    // MARK: - Частные помощники
    /// Отображение времени с учётом задержки
    @ViewBuilder
    private var timeSection: some View {
        let planned = extractTime(from: flight.scheduledInfo)

        if let fact = flight.expectedTime, fact != planned {
            HStack(spacing: 4) {
                Text(planned)
                    .foregroundColor(.secondary)
                    .strikethrough()
                Text(fact)
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
            }
        } else {
            Text(planned)
                .fontWeight(.semibold)
        }
    }

    /// Цвет для разных статусов (по ключевым словам)
    private func color(for status: String) -> Color {
        let s = status.lowercased()
        if s.contains("вылетел") || s.contains("прибыл") || s.contains("регистрация") {
            return .green
        } else if s.contains("задерж") {
            return .yellow
        } else if s.contains("отмен") {
            return .red
        } else if s.contains("посадк") {
            return .blue
        }
        return .primary
    }

    /// Из строки «… 19.05 в 02:50 тер. A» берём только «02:50»
    private func extractTime(from full: String) -> String {
        if let range = full.range(of: #"в\s(\d{2}:\d{2})"#,
                                  options: .regularExpression) {
            return String(full[range]).replacingOccurrences(of: "в ", with: "")
        }
        return full      // fallback — если формат изменится
    }
}
