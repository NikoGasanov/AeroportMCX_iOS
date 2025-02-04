//  Created by Niko Gasanov on 15.01.2025.



import Foundation

struct Flight: Identifiable {
    let id = UUID()                // Уникальный идентификатор рейса
    let flightNumber: String       // Номер рейста
    let destination: String        // Город прилета/Город вылета
    let status: String             // Статус рейса (задержан и тд.)
    let scheduledTime: String      // Запланированное время
    var actualTime: String?        // Фактическое время (если рейс задержан)
    let terminal: String?          // Номер термина
    let checkInDesk: String?       // Номер стойки регистрации
    let gate: String?              // Номер выхода
    let airline: String            // Название Авиакомпании
    let aircraft: String           // Название самолета
    var isSubscribed: Bool = false // Тумблер подписки (пока хз как делать)
}


