import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0  // 0 - Вылеты, 1 - Прилеты
    @State private var swipeProgress: CGFloat = 0  // Прогресс свайпа (реальное смещение)
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false
    @State private var currentDate = Date()

    var body: some View {
        VStack(spacing: 0) {
            // ————————— Верхняя панель —————————
            ZStack {
                Color(hex: "#47156B")
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 50)

                // Центрированный заголовок
                Text("Онлайн табло")
                    .font(.headline)
                    .foregroundColor(.white)

                // Кнопка поиска справа
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isSearching.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.trailing, 16)
                    }
                }
                .frame(height: 50)
            }

            // Кастомное поле поиска (если активно)
            if isSearching {
                VStack(spacing: 4) {
                    HStack {
                        TextField("Поиск", text: $viewModel.searchText)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .frame(height: 32)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isSearching = false
                                viewModel.searchText = ""
                                UIApplication.shared.endEditing()
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                }
                .padding(.top, 6)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            // … остальной код без изменений …
            CustomTabBar(selectedTab: $selectedSubTab, swipeProgress: $swipeProgress)

            Text(formattedDate(currentDate))
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 8)
                .padding(.bottom, 6)

            PagingScrollView(currentPage: $selectedSubTab, offset: $swipeProgress, pageCount: 2) {
                FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching)
                FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            swipeProgress = CGFloat(selectedSubTab)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: date).capitalized
    }
}

