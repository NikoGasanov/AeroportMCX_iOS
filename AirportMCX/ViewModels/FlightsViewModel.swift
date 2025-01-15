//
//  FlightsViewModel.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


import Foundation

class FlightsViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var searchText: String = ""

    init() {
        loadPlaceholderData()
    }

    func loadPlaceholderData() {
        flights = [
            Flight(flightNumber: "MCX123", destination: "Moscow", time: "12:30", status: "On Time"),
            Flight(flightNumber: "MCX456", destination: "Dubai", time: "14:00", status: "Delayed"),
            Flight(flightNumber: "MCX789", destination: "Istanbul", time: "16:15", status: "On Time")
        ]
    }

    var filteredFlights: [Flight] {
        if searchText.isEmpty {
            return flights
        } else {
            return flights.filter {
                $0.flightNumber.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
