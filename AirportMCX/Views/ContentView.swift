//
//  ContentView.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 15.01.2025.
//


//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedTab = 0 // Нижний TabBar: 0 - Табло, 1 - Паркинг, 2 - Бизнес залы, 3 - Навигация
//    @State private var selectedSubTab = 0 // Верхний TabBar: 0 - Вылеты, 1 - Прилеты
//    @StateObject private var viewModel = FlightsViewModel()
//    @State private var isSearching = false // Управляет режимом поиска
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            // Вкладка Табло
//            NavigationView {
//                VStack {
//                    // Верхний таб бар
//                    Picker("Выберите табло", selection: $selectedSubTab) {
//                        Text("Вылеты").tag(0)
//                        Text("Прилеты").tag(1)
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .padding()
//                    .onChange(of: selectedSubTab) { _ in
//                        // Закрытие поиска при смене вкладки
//                        withAnimation(.easeInOut) {
//                            isSearching = false
//                            viewModel.searchText = ""
//                            UIApplication.shared.endEditing()
//                        }
//                    }
//
//                    // TabView с возможностью свайпов
//                    TabView(selection: $selectedSubTab) {
//                        FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching) // Вылеты
//                            .tag(0)
//
//                        FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching) // Прилеты
//                            .tag(1)
//                    }
//                    .tabViewStyle(PageTabViewStyle()) // Свайпы между вкладками
//                    .animation(.easeInOut, value: selectedSubTab) // Плавная анимация при смене
//                }
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    // Либо заголовок, либо поле поиска (с анимацией)
//                    ToolbarItem(placement: .principal) {
//                        HStack {
//                            if isSearching {
//                                TextField("Поиск", text: $viewModel.searchText)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .transition(.move(edge: .trailing).combined(with: .opacity)) // Анимация появления
//                                    .overlay(
//                                        HStack {
//                                            Spacer()
//                                            Button(action: {
//                                                withAnimation(.easeInOut) {
//                                                    isSearching = false
//                                                    viewModel.searchText = "" // Очистка поиска
//                                                    UIApplication.shared.endEditing() // Закрытие клавиатуры
//                                                }
//                                            }) {
//                                                Image(systemName: "xmark.circle.fill")
//                                                    .foregroundColor(.gray)
//                                                    .padding(.trailing, 10)
//                                            }
//                                        }
//                                    )
//                                    .frame(height: 36)
//                            } else {
//                                Text(selectedSubTab == 0 ? "Табло Вылета" : "Табло Прилета")
//                                    .font(.headline)
//                                    .transition(.move(edge: .leading).combined(with: .opacity)) // Анимация заголовка
//                            }
//                        }
//                        .padding(.horizontal, 10)
//                    }
//
//                    // Кнопка поиска (🔍) с анимацией
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        if !isSearching {
//                            Button(action: {
//                                withAnimation(.easeInOut) {
//                                    isSearching = true
//                                }
//                            }) {
//                                Image(systemName: "magnifyingglass")
//                                    .transition(.scale) // Анимация появления/исчезновения кнопки
//                            }
//                        }
//                    }
//                }
//            }
//            .tabItem {
//                Label("Табло", systemImage: "list.bullet")
//            }
//            .tag(0)
//
//            // Вкладка Паркинг
//            NavigationView {
//                Text("Паркинг")
//                    .font(.largeTitle)
//                    .bold()
//            }
//            .tabItem {
//                Label("Паркинг", systemImage: "car.fill")
//            }
//            .tag(1)
//
//            // Вкладка Бизнес залы
//            NavigationView {
//                Text("Бизнес залы")
//                    .font(.largeTitle)
//                    .bold()
//            }
//            .tabItem {
//                Label("Бизнес залы", systemImage: "briefcase.fill")
//            }
//            .tag(2)
//
//            // Вкладка Навигация
//            NavigationView {
//                Text("Навигация")
//                    .font(.largeTitle)
//                    .bold()
//            }
//            .tabItem {
//                Label("Навигация", systemImage: "map.fill")
//            }
//            .tag(3)
//        }
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0 // Нижний TabBar: 0 - Табло, 1 - Паркинг, 2 - Бизнес залы, 3 - Навигация
    @State private var selectedSubTab = 0 // Верхний TabBar: 0 - Вылеты, 1 - Прилеты
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false // Управляет режимом поиска

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
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedSubTab) { _ in
                        // Закрытие поиска при смене вкладки
                        withAnimation(.easeInOut) {
                            isSearching = false
                            viewModel.searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    }

                    // TabView с возможностью свайпов
                    TabView(selection: $selectedSubTab) {
                        FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching) // Вылеты
                            .tag(0)

                        FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching) // Прилеты
                            .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle()) // Свайпы между вкладками
                    .animation(.easeInOut, value: selectedSubTab) // Плавная анимация при смене
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Либо заголовок, либо кастомная поисковая строка на всю ширину
                    ToolbarItem(placement: .principal) {
                        GeometryReader { geometry in
                            VStack(spacing: 0) {
                                HStack {
                                    if isSearching {
                                        TextField("Поиск", text: $viewModel.searchText)
                                            .padding(.vertical, 8)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading) // Текст идет слева
                                            .frame(width: geometry.size.width - 50) // Фиксированная ширина
                                            .transition(.move(edge: .trailing).combined(with: .opacity)) // Анимация появления

                                        // Крестик для очистки и закрытия поиска
                                        Button(action: {
                                            withAnimation(.easeInOut) {
                                                isSearching = false
                                                viewModel.searchText = "" // Очистка поиска
                                                UIApplication.shared.endEditing() // Закрытие клавиатуры
                                            }
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 10)
                                        }
                                    } else {
                                        Text(selectedSubTab == 0 ? "Табло Вылета" : "Табло Прилета")
                                            .font(.headline)
                                            .transition(.move(edge: .leading).combined(with: .opacity)) // Анимация заголовка
                                    }
                                }
                                .frame(width: geometry.size.width) // Гарантируем, что поле занимает всю ширину

                                // Черная полоска-разделитель (на всю ширину)
                                if isSearching {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.black)
                                        .transition(.opacity)
                                }
                            }
                            .frame(width: geometry.size.width) // Гарантия, что все элементы внутри занимают всю ширину
                        }
                        .frame(height: 44) // Высота заголовка
                    }

                    // Кнопка поиска (🔍) с анимацией
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !isSearching {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    isSearching = true
                                }
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .transition(.scale) // Анимация появления/исчезновения кнопки
                            }
                        }
                    }
                }
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

