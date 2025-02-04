import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0 // Активная вкладка
    @State private var swipeProgress: CGFloat = 0 // Прогресс полоски
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false // Управляет поиском
    @State private var currentDate = Date() // Храним текущую дату

    var body: some View {
        VStack(spacing: 0) {
            // Верхняя панель с Онлайн табло
            ZStack {
                Color(hex: "#FF00C0")
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 50) // Высота верхней панели


                Text("Онлайн табло")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)


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

                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Кастомное поле поиска без границ (zaep)
            if isSearching {
                VStack(spacing: 4) {
                    HStack {
                        TextField("Поиск", text: $viewModel.searchText)
                            .font(.system(size: 18)) // Размер текста
                            .foregroundColor(.black) // Черный текст
                            .padding(.vertical, 6)
                            .background(Color.clear)
                            .accentColor(.black)

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
                .padding(.top, 6) // Отступ под "Верхняя панель с Онлайн табло"
                .transition(.move(edge: .top).combined(with: .opacity)) // Анимация появления
            }

            // Кастомный Tab Bar с полоской
            CustomTabBar(selectedTab: $selectedSubTab, swipeProgress: $swipeProgress)

            // Дата под верхним таб-баром (колхоз + перегруз UI)
//            Text(formattedDate(currentDate))
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .padding(.top, 6)
//                .padding(.bottom, 4)

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
        .navigationBarHidden(true) // Скрываем стандартный Navigation Bar
    }

// Функция для форматирования даты
    
//    private func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ru_RU") // Русская локализация
//        formatter.dateFormat = "EEEE, d MMMM" // Формат: Понедельник, 29 января
//        return formatter.string(from: date).capitalized // Делаем первую букву заглавной
//    }
}
