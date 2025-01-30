//
//  ContentView.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0 // Нижний TabBar

    var body: some View {
        TabView(selection: $selectedTab) {
            // Вкладка Табло
            NavigationView {
                TabloView()
            }
            .tabItem {
                Label("Табло", systemImage: "list.bullet")
            }
            .tag(0)

            // Вкладка Паркинг
            NavigationView {
                ParkingView()
            }
            .tabItem {
                Label("Паркинг", systemImage: "car.fill")
            }
            .tag(1)

            // Вкладка Бизнес залы
            NavigationView {
                BusinessLoungeView()
            }
            .tabItem {
                Label("Бизнес залы", systemImage: "briefcase.fill")
            }
            .tag(2)

            // Вкладка Навигация
            NavigationView {
                NavigationScreenView()
            }
            .tabItem {
                Label("Навигация", systemImage: "map.fill")
            }
            .tag(3)
        }
    }
}
