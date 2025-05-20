//
//  Flight.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//

import Foundation

struct Flight: Identifiable, Decodable {
    let id = UUID()
    let flightNumber: String          // Рейс
    let airline: String               // Авиакомпания
    let direction: String             // Направление (город + дата)

    /// Только город (до запятой)
    var city: String {
        direction
            .components(separatedBy: ",")
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            ?? direction
    }

    let scheduledInfo: String         // Время вылета или Время прилета
    let expectedTime: String?         // Ожидаемое время
    let status: String                // Статус
    let aircraft: String              // Воздушное судно

    // Для вылетов
    let registrationStart: String?    // Регистрация, начало
    let registrationEnd: String?      // Регистрация, окончание
    let boardingEnd: String?          // Посадка, завершение

    // MARK: – CodingKeys

    private enum CodingKeys: String, CodingKey {
        case flightNumber      = "Рейс"
        case airline           = "Авиакомпания"
        case direction         = "Направление"
        case timeDeparture     = "Время вылета"
        case timeArrival       = "Время прилета"
        case expectedTime      = "Ожидаемое время"
        case status            = "Статус"
        case aircraft          = "Воздушное судно"
        case registrationStart = "Регистрация, начало"
        case registrationEnd   = "Регистрация, окончание"
        case boardingEnd       = "Посадка, завершение"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber      = try c.decode(String.self, forKey: .flightNumber)
        airline           = try c.decode(String.self, forKey: .airline)
        direction         = try c.decode(String.self, forKey: .direction)

        // Время вылета или время прилёта
        if let dep = try? c.decode(String.self, forKey: .timeDeparture) {
            scheduledInfo = dep
        } else {
            scheduledInfo = try c.decode(String.self, forKey: .timeArrival)
        }

        expectedTime      = try? c.decode(String.self, forKey: .expectedTime)
        status            = try c.decode(String.self, forKey: .status)
        aircraft          = try c.decode(String.self, forKey: .aircraft)

        registrationStart = try? c.decode(String.self, forKey: .registrationStart)
        registrationEnd   = try? c.decode(String.self, forKey: .registrationEnd)
        boardingEnd       = try? c.decode(String.self, forKey: .boardingEnd)
    }
}
