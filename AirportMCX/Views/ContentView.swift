//
//  ContentView.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedTab = 0 // Индекс выбранной вкладки
//    @StateObject private var viewModel = FlightsViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Верхний TabBar
//                Picker("Выберите таб", selection: $selectedTab) {
//                    Text("Табло Вылета").tag(0)
//                    Text("Табло Прилета").tag(1)
//                }
//                .pickerStyle(SegmentedPickerStyle()) // Сегментированный контроль для табов
//                .padding()
//
//                // TabView с возможностью свайпа
//                TabView(selection: $selectedTab) {
//                    FlightListView(viewModel: viewModel, tab: 0) // Табло Вылета
//                        .tag(0)
//
//                    FlightListView(viewModel: viewModel, tab: 1) // Табло Прилета
//                        .tag(1)
//                }
//                .tabViewStyle(PageTabViewStyle()) // Свайпы между таблицами
//            }
//            .navigationTitle(selectedTab == 0 ? "Табло Вылета" : "Табло Прилета") // Заголовок для NavigationView
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0 // Нижний TabBar: 0 - Табло, 1 - Паркинг, 2 - Бизнес залы, 3 - Навигация
    @State private var selectedSubTab = 0 // Верхний TabBar: 0 - Вылеты, 1 - Прилеты
    @StateObject private var viewModel = FlightsViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            // Вкладка Табло
            NavigationView {
                VStack {
                    // Верхний таб бар
                    Picker("Выберите табло", selection: $selectedSubTab) {
                        Text("Вылеты").tag(0)
                        Text("Прилеты").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Сегментированный переключатель
                    .padding()

                    // TabView с возможностью свайпов
                    TabView(selection: $selectedSubTab) {
                        FlightListView(viewModel: viewModel, tab: 0) // Табло вылета
                            .tag(0)

                        FlightListView(viewModel: viewModel, tab: 1) // Табло прилета
                            .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle()) // Свайпы между вкладками
                    .animation(.easeInOut, value: selectedSubTab) // Плавная анимация при смене
                }
                .navigationTitle("Табло")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Табло", systemImage: "list.bullet")
            }
            .tag(0)

            // Вкладка Паркинг
            NavigationView {
                Text("Паркинг")
                    .font(.largeTitle)
                    .bold()
            }
            .tabItem {
                Label("Паркинг", systemImage: "car.fill")
            }
            .tag(1)

            // Вкладка Бизнес залы
            NavigationView {
                Text("Бизнес залы")
                    .font(.largeTitle)
                    .bold()
            }
            .tabItem {
                Label("Бизнес залы", systemImage: "briefcase.fill")
            }
            .tag(2)

            // Вкладка Навигация
            NavigationView {
                Text("Навигация")
                    .font(.largeTitle)
                    .bold()
            }
            .tabItem {
                Label("Навигация", systemImage: "map.fill")
            }
            .tag(3)
        }
    }
}
