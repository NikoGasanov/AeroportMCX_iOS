import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FlightListView: View {
    @StateObject var viewModel: FlightsViewModel
    let tab: Int // 0 - Прилеты, 1 - Вылеты

    var body: some View {
            VStack(spacing: 0) {
                // Заголовок
                Text(tab == 0 ? "Табло Вылета" : "Табло Прилета")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .horizontal])

                // Поле поиска
                TextField("Поиск", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .submitLabel(.done)
                    .onSubmit {
                        UIApplication.shared.endEditing()
                    }

                // Контейнер для списка рейсов
                ZStack {
                    if viewModel.filteredFlights(for: tab).isEmpty {
                        Text("По вашему запросу ничего не найдено")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(viewModel.filteredFlights(for: tab)) { flight in
                            NavigationLink(destination: FlightDetailView(flight: flight)) {
                                FlightRow(flight: flight)
                            }
                            .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)) // Настраиваем отступы
                        }
                        .listRowSeparator(.hidden) // Скрываем системные разделители
                        .listStyle(PlainListStyle()) // Убираем лишние стили
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Фиксируем размер контейнера
                .background(Color.clear) // Добавляем прозрачный фон, чтобы можно было перехватывать жесты
            }
            .navigationBarHidden(true) // Скрываем стандартный NavigationBar
            .background(
                // Используем фон только для закрытия клавиатуры
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.endEditing() // Закрываем клавиатуру
                    }
            )
    }
}

