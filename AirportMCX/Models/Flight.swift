import Foundation

struct Flight: Identifiable {
    let id = UUID()
    let flightNumber: String
    let destination: String
    let time: String
    let status: String
}
