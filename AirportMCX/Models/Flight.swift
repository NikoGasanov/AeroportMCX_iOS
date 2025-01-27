//
//  Flight.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


import Foundation

struct Flight: Identifiable {
    let id = UUID()
    let flightNumber: String
    let destination: String
    let status: String
    let scheduledTime: String // Запланированное время
    var actualTime: String?   // Фактическое время (если рейс задержан)
    let terminal: String?
    let checkInDesk: String?
    let gate: String?
    let airline: String
    let aircraft: String
    var isSubscribed: Bool = false
}


