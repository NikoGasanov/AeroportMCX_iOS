//  Created by Niko Gasanov on 15.01.2025.

import Foundation

struct Flight: Identifiable, Decodable {
    let id = UUID()
    let flightNumber: String          // «Рейс»
    let airline: String               // «Авиакомпания»
    let direction: String             // «Направление»  (город + дата)
    let scheduledInfo: String         // «Время вылета» ИЛИ «Время прилета»
    let expectedTime: String?         // «Ожидаемое время»
    let status: String                // «Статус»
    let aircraft: String              // «Воздушное судно»
    
    // Для вылётов
    let registrationStart: String?
    let registrationEnd: String?
    let boardingEnd: String?

    // сопоставление JSON
    enum CodingKeys: String, CodingKey {
        case flightNumber       = "Рейс"
        case airline            = "Авиакомпания"
        case direction          = "Направление"
        case timeDeparture      = "Время вылета"   // будет только в departures
        case timeArrival        = "Время прилета"  // будет только в arrivals
        case expectedTime       = "Ожидаемое время"
        case status             = "Статус"
        case aircraft           = "Воздушное судно"
        case registrationStart  = "Регистрация, начало"
        case registrationEnd    = "Регистрация, окончание"
        case boardingEnd        = "Посадка, завершение"
    }

    // инициализатор, чтобы выбрать «Время прилета/вылета»
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        
        flightNumber       = try c.decode(String.self, forKey: .flightNumber)
        airline            = try c.decode(String.self, forKey: .airline)
        direction          = try c.decode(String.self, forKey: .direction)
        expectedTime       = try? c.decode(String.self, forKey: .expectedTime)
        status             = try c.decode(String.self, forKey: .status)
        aircraft           = try c.decode(String.self, forKey: .aircraft)
        registrationStart  = try? c.decode(String.self, forKey: .registrationStart)
        registrationEnd    = try? c.decode(String.self, forKey: .registrationEnd)
        boardingEnd        = try? c.decode(String.self, forKey: .boardingEnd)
        
        // ловим один из двух ключей времени
        if let t = try? c.decode(String.self, forKey: .timeDeparture) {
            scheduledInfo = t
        } else {
            scheduledInfo = try c.decode(String.self, forKey: .timeArrival)
        }
    }
}



