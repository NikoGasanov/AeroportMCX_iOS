import SwiftUI

struct PagingScrollView<Content: View>: View {
    @Binding var currentPage: Int
    @Binding var offset: CGFloat  // Текущее смещение (в виде дробного номера страницы)
    let pageCount: Int
    let content: Content
    // Допустимый overscroll не фиксируем, а используем rubber band эффект

    init(currentPage: Binding<Int>, offset: Binding<CGFloat>, pageCount: Int, @ViewBuilder content: () -> Content) {
        self._currentPage = currentPage
        self._offset = offset
        self.pageCount = pageCount
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    content
                        .frame(width: geometry.size.width)
                }
            }
            // Используем offset для смещения контента
            .content.offset(x: -offset * geometry.size.width)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let progress = -value.translation.width / geometry.size.width
                        var newOffset = CGFloat(currentPage) + progress
                        // Применяем rubber band эффект при выходе за границы:
                        if newOffset < 0 {
                            newOffset = newOffset / 2
                        }
                        if newOffset > CGFloat(pageCount - 1) {
                            newOffset = CGFloat(pageCount - 1) + (newOffset - CGFloat(pageCount - 1)) / 2
                        }
                        withTransaction(Transaction(animation: nil)) {
                            offset = newOffset
                        }
                    }
                    .onEnded { value in
                        let progress = -value.translation.width / geometry.size.width
                        var newPage = CGFloat(currentPage) + progress
                        newPage = newPage.rounded()  // Округляем до ближайшей страницы
                        newPage = min(max(newPage, 0), CGFloat(pageCount - 1))
                        withAnimation(.easeInOut) {
                            currentPage = Int(newPage)
                            offset = newPage
                        }
                    }
            )
        }
    }
}

