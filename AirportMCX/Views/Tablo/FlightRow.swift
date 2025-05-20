import SwiftUI

struct FlightRow: View {
    let flight: Flight

    var body: some View {
        HStack {
            // ─── Левая колонка ──────────────────────────
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.flightNumber)
                    .font(.headline)
                Text(flight.direction)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // ─── Правая колонка ─────────────────────────
            VStack(alignment: .trailing, spacing: 4) {
                timeSection
                Text(flight.status)
                    .font(.subheadline)
                    .foregroundColor(color(for: flight.status))
            }
        }
        .padding(.vertical, 8)
    }

    /// Показ времени — учитываем задержку
    @ViewBuilder
    private var timeSection: some View {
        if let exp = flight.expectedTime, exp != extractTime(from: flight.scheduledInfo) {
            // задержка: показываем плановое зачёркнутым и фактическое красным
            HStack(spacing: 4) {
                Text(extractTime(from: flight.scheduledInfo))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .strikethrough()
                Text(exp)
                    .font(.headline)
                    .foregroundColor(.red)
            }
        } else {
            // по расписанию
            Text(extractTime(from: flight.scheduledInfo))
                .font(.headline)
        }
    }

    /// Подсветка статуса
    private func color(for status: String) -> Color {
        switch status.lowercased() {
        case let s where s.contains("вылетел"),
             let s where s.contains("прибыл"),
             let s where s.contains("регистрация"):
            return .green
        case let s where s.contains("задерж"):
            return .yellow
        case let s where s.contains("отмен"):
            return .red
        case let s where s.contains("посадк"):
            return .blue
        default:
            return .primary
        }
    }

    /// Из строки «… 19.05 в 02:50 тер. A» вытаскиваем только «02:50»
    private func extractTime(from full: String) -> String {
        // находим последнюю подстроку «в HH:MM»
        if let range = full.range(of: #"в\s(\d{2}:\d{2})"#,
                                  options: .regularExpression) {
            return String(full[range]).replacingOccurrences(of: "в ", with: "")
        }
        return full   // fallback
    }
}
