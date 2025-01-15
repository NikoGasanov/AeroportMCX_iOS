import SwiftUI

struct FlightRow: View {
    let flight: Flight

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flight.flightNumber).font(.headline)
                Text(flight.destination).font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(flight.time).font(.headline)
                Text(flight.status)
                    .font(.subheadline)
                    .foregroundColor(flight.status == "On Time" ? .green : .red)
            }
        }
        .padding()
    }
}
