import SwiftUI

struct FlightDetailView: View {
    let flight: Flight

    var body: some View {
        VStack(spacing: 20) {
            Text("Flight Details").font(.largeTitle).bold()
            Text("Flight Number: \(flight.flightNumber)")
            Text("Destination: \(flight.destination)")
            Text("Time: \(flight.time)")
            Text("Status: \(flight.status)")
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
