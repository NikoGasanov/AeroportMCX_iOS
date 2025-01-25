//
//  ContentView.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0 // Индекс выбранной вкладки
    @StateObject private var viewModel = FlightsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Верхний TabBar
                Picker("Выберите таб", selection: $selectedTab) {
                    Text("Табло Вылета").tag(0)
                    Text("Табло Прилета").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle()) // Сегментированный контроль для табов
                .padding()

                // TabView с возможностью свайпа
                TabView(selection: $selectedTab) {
                    FlightListView(viewModel: viewModel, tab: 0) // Табло Вылета
                        .tag(0)

                    FlightListView(viewModel: viewModel, tab: 1) // Табло Прилета
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle()) // Свайпы между таблицами
            }
            .navigationTitle(selectedTab == 0 ? "Табло Вылета" : "Табло Прилета") // Заголовок для NavigationView
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



