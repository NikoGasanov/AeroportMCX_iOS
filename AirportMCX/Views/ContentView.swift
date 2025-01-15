import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FlightListView(title: "Arrivals")
                .tabItem {
                    Label("Arrivals", systemImage: "airplane.arrival")
                }

            FlightListView(title: "Departures")
                .tabItem {
                    Label("Departures", systemImage: "airplane.departure")
                }
        }
    }
}
