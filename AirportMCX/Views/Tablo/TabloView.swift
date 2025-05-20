// TabloView.swift

import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0
    @State private var swipeProgress: CGFloat = 0  // больше не нужен, но оставим, вдруг что-то ещё на него завязано
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false
    @State private var currentDate = Date()

    var body: some View {
        VStack(spacing: 0) {
            // ——— Шапка с градиентом ———
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#47156B"), Color(hex: "#D5335C")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea(edges: .top)
            .frame(height: 60)
            .overlay(
                ZStack {
                    Text("Онлайн табло")
                        .font(.headline)
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        Button {
                            withAnimation { isSearching.toggle() }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.trailing, 16)
                        }
                    }
                }
            )

            // ——— Поиск ———
            if isSearching {
                VStack(spacing: 4) {
                    HStack {
                        TextField("Поиск", text: $viewModel.searchText)
                            .font(.system(size: 18))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        Button {
                            withAnimation {
                                isSearching = false
                                viewModel.searchText = ""
                                UIApplication.shared.endEditing()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.black)
                }
                .padding(.top, 6)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            // ——— Ваш кастомный сегмент ———
            CustomTabBar(selectedTab: $selectedSubTab, swipeProgress: $swipeProgress)

            // ——— Дата ———
            Text(formattedDate(currentDate))
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.vertical, 8)

            // ——— Здесь TabView заменяет PagingScrollView ———
            TabView(selection: $selectedSubTab) {
                FlightListView(
                    viewModel: viewModel,
                    selectedTab: $selectedSubTab,
                    isSearching: $isSearching
                )
                .tag(0)

                FlightListView(
                    viewModel: viewModel,
                    selectedTab: $selectedSubTab,
                    isSearching: $isSearching
                )
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            // тянем на всю оставшуюся область:
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onAppear {
            // если вы где-то ещё используете swipeProgress
            swipeProgress = CGFloat(selectedSubTab)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "EEEE, d MMMM"
        return f.string(from: date).capitalized
    }
}

