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
    private let baseURL = URL(string: "http://172.20.10.11:8000/flights/")!
    
    // внутренняя обёртка под JSON:
    // {
    //   "data": [ { …поля рейса… }, { … } ]
    // }
    private struct FlightsResponse: Decodable {
        let data: [Flight]
    }
    
    // Настроенный декодер один раз
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    /// Забираем массив рейсов для given type (arrivals/departures)
    func fetchFlights(_ type: FlightType) async throws -> [Flight] {
        let url = baseURL.appendingPathComponent(type.rawValue)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let jsonStr = String(data: data, encoding: .utf8) {
            print("❗️Flights JSON:\n\(jsonStr)")
        } else {
            print("❗️Flights JSON: <не удалось декодировать в UTF-8>")
        }
        
        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // decode wrapper и возвращаем .data
        let wrapper = try decoder.decode(FlightsResponse.self, from: data)
        return wrapper.data
    }
    
    /// Параллельно забираем и прилёты, и вылеты
    func fetchAll() async throws -> (arrivals: [Flight], departures: [Flight]) {
        async let arr = fetchFlights(.arrival)
        async let dep = fetchFlights(.departure)
        return try await (arrivals: arr, departures: dep)
    }
}










// http://192.168.88.19:8000/flights
