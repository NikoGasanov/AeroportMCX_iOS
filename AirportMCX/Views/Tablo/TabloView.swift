import SwiftUI

struct TabloView: View {
    @State private var selectedSubTab = 0 // Активная вкладка
    @State private var swipeProgress: CGFloat = 0 // Прогресс полоски
    @StateObject private var viewModel = FlightsViewModel()
    @State private var isSearching = false // Управляет поиском

    var body: some View {
        VStack(spacing: 0) {
            // Верхняя розовая панель с "Онлайн табло" и 🔍
            ZStack {
                Color(hex: "#4e106f") // Фон ярко-розового цвета (#4e106f)/(#FF00C0)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height:50) // Высота верхней панели

                // Текст "Онлайн табло" в центре
                Text("Онлайн табло")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)

                // Кнопка 🔍 справа
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
                .frame(maxWidth: .infinity, alignment: .trailing) // Выравниваем кнопку вправо
            }

            // Кастомное поле поиска без границ
            if isSearching {
                VStack(spacing: 4) {
                    HStack {
                        TextField("Поиск", text: $viewModel.searchText)
                            .font(.system(size: 18)) // Размер текста
                            .foregroundColor(.black) // Черный текст
                            .padding(.vertical, 6)
                            .background(Color.clear) // Полностью убираем фон
                            .accentColor(.black) // Цвет курсора

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

                    // Черная полоска-разделитель на всю ширину экрана
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                }
                .padding(.top, 6) // Отступ под розовой частью
                .transition(.move(edge: .top).combined(with: .opacity)) // Анимация появления
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
        .navigationBarHidden(true) // Скрываем стандартный Navigation Bar
    }
}
