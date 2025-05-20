import SwiftUI

struct FlightRow: View {
    let flight: Flight

    var body: some View {
        HStack {
            // ─── Левая колонка ──────────────────────────
            VStack(alignment: .leading, spacing: 4) {
                // теперь показываем только город
                Text(flight.city)
                    .font(.headline)
                Text(flight.flightNumber)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // ─── Правая колонка ─────────────────────────
            VStack(alignment: .trailing, spacing: 4) {
                Text(extractTime(from: flight.scheduledInfo))
                    .font(.headline)
                if let exp = flight.expectedTime {
                    Text(extractTime(from: exp))
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding(.vertical, 8)
    }

    //
    private func extractTime(from full: String) -> String {
        if let range = full.range(of: #"в\s(\d{2}:\d{2})"#,
                                  options: .regularExpression) {
            return String(full[range]).replacingOccurrences(of: "в ", with: "")
        }
        return full   // fallback
    }
}
