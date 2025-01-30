import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0 // Активная вкладка
    @State private var swipeProgress: CGFloat = 0 // Прогресс полоски (не синхронный)
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false // Управляет поиском

    var body: some View {
        VStack(spacing: 0) {
            // Поисковая строка
            if isSearching {
                VStack(spacing: 0) {
                    HStack {
                        TextField("Поиск", text: $viewModel.searchText)
                            .padding(.vertical, 8)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .frame(width: 350)

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
                    .padding(.horizontal, 10)

                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundColor(.black)
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .padding(.bottom, 8)
            }

            // Кастомный Tab Bar с полоской
            CustomTabBar(selectedTab: $selectedSubTab, swipeProgress: $swipeProgress)

            // TabView с обычным свайпом без синхронизации полоски
            TabView(selection: $selectedSubTab) {
                FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching)
                    .tag(0)

                FlightListView(viewModel: viewModel, selectedTab: $selectedSubTab, isSearching: $isSearching)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .onChange(of: selectedSubTab) { newValue in
                withAnimation(.easeInOut) {
                    swipeProgress = CGFloat(newValue) // Полоска меняется после свайпа
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if !isSearching {
                    Text(selectedSubTab == 0 ? "Табло Вылета" : "Табло Прилета")
                        .font(.headline)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                if !isSearching {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isSearching = true
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .transition(.scale)
                    }
                }
            }
        }
    }
}
