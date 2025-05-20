//
//  FlightType.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 19.05.2025.
//

import Foundation

enum FlightType: String {          // удобное перечисление
    case arrival    = "arrivals"
    case departure  = "departures"
}



actor FlightService {
    static let shared = FlightService()
    private let baseURL = URL(string: "http://127.0.0.1:8000/flights/")!        //http://192.168.88.19:8000/flights
    
    // внутренняя обёртка
    private struct FlightsResponse: Decodable {
        let data: [Flight]
    }
    
    private let decoder: JSONDecoder = JSONDecoder()   // (пока) достаточно дефолтного
    
    func fetchFlights(_ type: FlightType) async throws -> [Flight] {
        let url = baseURL.appendingPathComponent(type.rawValue)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // декодирование в FlightsResponse потом берём .data
        return try decoder.decode(FlightsResponse.self, from: data).data
    }
    
    // параллельный запрос прилётов и вылетов
    func fetchAll() async throws -> (arrivals:[Flight], departures:[Flight]) {
        async let arr = fetchFlights(.arrival)
        async let dep = fetchFlights(.departure)
        return try await (arrivals: arr, departures: dep)
    }
}
