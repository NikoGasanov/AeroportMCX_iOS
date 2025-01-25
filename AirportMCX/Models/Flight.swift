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
    let time: String
    let status: String
    let terminal: String
}
