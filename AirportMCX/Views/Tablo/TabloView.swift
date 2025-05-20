//  TabloView.swift
//  AirportMCX
//
//  Created by Your Name on 20.05.2025.
//

import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

struct TabloView: View {
    @State private var selectedSubTab = 0          // 0 — Вылеты, 1 — Прилеты
    @State private var swipeProgress: CGFloat = 0  // для кастомного Paging
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false
    @State private var currentDate = Date()
    @FocusState private var searchFieldFocused: Bool

    var body: some View {
        ZStack {
            // Фоновая область: ловим тапы вне поля поиска
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if isSearching {
                        closeSearch()
                    }
                }

            VStack(spacing: 0) {
                header
                searchField
                CustomTabBar(selectedTab: $selectedSubTab,
                             swipeProgress: $swipeProgress)
                dateView
                PagingScrollView(currentPage: $selectedSubTab,
                                 offset: $swipeProgress,
                                 pageCount: 2) {
                    FlightListView(viewModel: viewModel,
                                   selectedTab: $selectedSubTab)
                    FlightListView(viewModel: viewModel,
                                   selectedTab: $selectedSubTab)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                swipeProgress = CGFloat(selectedSubTab)
            }
            .onChange(of: isSearching) { newValue in
                if newValue {
                    // при открытии поиска — фокусируем TextField
                    DispatchQueue.main.async {
                        searchFieldFocused = true
                    }
                }
            }
        }
    }

    // MARK: — Header

    private var header: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#47156B"), Color(hex: "#D5335C")]),
                           startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 60)

            Text("Онлайн табло")
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        isSearching.toggle()
                        if !isSearching {
                            viewModel.searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.trailing, 16)
                }
            }
            .frame(height: 60)
        }
        .frame(height: 60)
    }

    // MARK: — Search Field

    private var searchField: some View {
        Group {
            if isSearching {
                HStack {
                    TextField("Поиск рейса или города", text: $viewModel.searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .focused($searchFieldFocused)
                        .onSubmit {
                            closeSearch()
                        }
                        .onChange(of: viewModel.searchText) { text in
                            if text.isEmpty {
                                closeSearch()
                            }
                        }

                    Button {
                        closeSearch()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1),
                                radius: 2, x: 0, y: 1)
                )
                .padding(.horizontal, 0)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }

    // MARK: — Date View

    private var dateView: some View {
        Text(formattedDate(currentDate))
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 6)
    }

    // MARK: — Helpers

    private func closeSearch() {
        withAnimation {
            isSearching = false
            viewModel.searchText = ""
            UIApplication.shared.endEditing()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "EEEE, d MMMM"
        return f.string(from: date).capitalized
    }
}

struct TabloView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabloView()
        }
    }
}
