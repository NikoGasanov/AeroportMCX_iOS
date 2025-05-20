// FlightRow.swift

import SwiftUI

struct FlightRow: View {
    let flight: Flight

    var body: some View {
        HStack {
            // Левая колонка: город/маршрут + номер рейса
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.direction)
                    .font(.headline)
                    .foregroundColor(.primary)    // чёрный
                Text(flight.flightNumber)
                    .font(.subheadline)
                    .foregroundColor(.secondary)  // серый
            }

            Spacer()

            // Правая колонка: время
            timeSection
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
    }

    // MARK: — Время вылета/прилёта (план/факт)
    @ViewBuilder
    private var timeSection: some View {
        if let actual = flight.expectedTime, actual != scheduledTime {
            HStack(spacing: 4) {
                Text(scheduledTime)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .strikethrough()
                Text(actual)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        } else {
            Text(scheduledTime)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }

    private var scheduledTime: String {
        extractTime(from: flight.scheduledInfo)
    }

    // Извлечь время «HH:MM» из строки вида «… 19.05 в 02:50 тер. A»
    private func extractTime(from full: String) -> String {
        if let range = full.range(of: #"в\s(\d{2}:\d{2})"#, options: .regularExpression) {
            return String(full[range]).replacingOccurrences(of: "в ", with: "")
        }
        return full
    }
}


