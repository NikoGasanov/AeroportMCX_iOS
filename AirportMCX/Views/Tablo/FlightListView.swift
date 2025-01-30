import SwiftUI
import UIKit

//extension UIApplication {
//    func endEditing() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//
//struct FlightListView: View {
//    @StateObject var viewModel: FlightsViewModel
//    let tab: Int // 0 - Прилеты, 1 - Вылеты
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // Заголовок
//            Text(tab == 0 ? "Табло Вылета" : "Табло Прилета")
//                .font(.largeTitle)
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding([.top, .horizontal])
//
//            // Поле поиска
//            TextField("Поиск", text: $viewModel.searchText)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//                .overlay(
//                    HStack {
//                        Spacer()
//                        if !viewModel.searchText.isEmpty {
//                            Button(action: {
//                                viewModel.searchText = "" // Очистить текст
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 25) // Отступ внутри поля
//                            }
//                        }
//                    }
//                )
//                .frame(height: 36) // Устанавливаем фиксированную высоту
//
//            // Контейнер для списка рейсов
//            ZStack {
//                if viewModel.filteredFlights(for: tab).isEmpty {
//                    Text("По вашему запросу ничего не найдено")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    // Список рейсов с NavigationLink
//                    List(viewModel.filteredFlights(for: tab)) { flight in
//                        NavigationLink(
//                            destination: FlightDetailView(flight: flight, isDeparture: tab == 0) // Передача рейса и типа таба
//                        ) {
//                            FlightRow(flight: flight) // Строка рейса
//                        }
//                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
//                    }
//                    .listStyle(PlainListStyle()) // Убираем лишние стили
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity) // Фиксируем размер контейнера
//            .background(Color.clear) // Прозрачный фон
//        }
//        .navigationBarHidden(true) // Скрываем стандартный NavigationBar
//        .background(
//            // Закрытие клавиатуры при касании вне текстового поля
//            Color.clear
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    UIApplication.shared.endEditing()
//                }
//        )
//    }
//}


import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    @Binding var selectedTab: Int // Синхронизируем вкладки Прилеты/Вылеты
    @Binding var isSearching: Bool // Управляет поиском

    var body: some View {
        VStack(spacing: 0) {
            // Контейнер для списка рейсов
            ZStack {
                if viewModel.filteredFlights(for: selectedTab).isEmpty {
                    Text("По вашему запросу ничего не найдено")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.filteredFlights(for: selectedTab)) { flight in
                        NavigationLink(
                            destination: FlightDetailView(flight: flight, isDeparture: selectedTab == 0)
                        ) {
                            FlightRow(flight: flight)
                        }
                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
        }
        .onChange(of: selectedTab) { _ in
            // Закрываем поиск при смене вкладки
            withAnimation {
                isSearching = false
                viewModel.searchText = ""
                UIApplication.shared.endEditing()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
