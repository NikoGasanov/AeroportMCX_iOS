import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var swipeProgress: CGFloat
    let tabTitles = ["Вылеты", "Прилеты"]
    let tabIcons = ["airplane.departure", "airplane.arrival"] // системные икнонки взлета/посадки

    var body: some View {
        GeometryReader { geometry in
            let tabWidth = geometry.size.width / CGFloat(tabTitles.count) // Ширина одного таба
            let indicatorWidth = tabWidth / 1.5 // Полоска в 1.5 раза Уже

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0..<tabTitles.count, id: \.self) { index in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = index
                                swipeProgress = CGFloat(index) // Полоска двигается после нажатия
                            }
                        }) {
                            HStack {
                                Image(systemName: tabIcons[index])
                                    .font(.system(size: 16))
                                Text(tabTitles[index])
                                    .font(.headline)
                            }
                            .foregroundColor(selectedTab == index ? .black : .gray) // Активный - черный, неактивный - серый
                            .frame(width: tabWidth, height: 40)
                        }
                    }
                }

                // Полоска с закругленными краями
                Rectangle()
                    .fill(Color(hex: "#D5335C")) //#4E106F
                    .frame(width: indicatorWidth, height: 3)
                    .cornerRadius(1.5) // Закругленние краев
                    .offset(x: swipeProgress * tabWidth - geometry.size.width / 2 + tabWidth / 2)
                    .animation(.easeInOut(duration: 0.3), value: swipeProgress) // Движение после свайпа
            }
            .frame(width: geometry.size.width)
        }
        .frame(height: 50) // Высота кастомного таб бара
    }
}

// Расширение для HEX-цветов (зач я это сделал?)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xff, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Черный по умолчанию
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



