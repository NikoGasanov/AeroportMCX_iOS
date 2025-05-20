import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0  // 0 - Вылеты, 1 - Прилеты
    @State private var swipeProgress: CGFloat = 0  // Прогресс свайпа (реальное смещение)
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false
    @State private var currentDate = Date()

    var body: some View {
        VStack(spacing: 0) {
            //  Верхняя панель
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#47156B"), Color(hex: "#D5335C")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .edgesIgnoringSafeArea(.top)
                .frame(height: 60)

                Text("Онлайн табло")
                    .font(.headline)
                    .foregroundColor(.white)

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
                .frame(height: 60)
            }
            .frame(height: 60)

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

