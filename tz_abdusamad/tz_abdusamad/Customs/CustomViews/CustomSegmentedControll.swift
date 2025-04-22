import SwiftUI

struct CustomSegmentedControll: View {
    @Binding var selectedSegment: Int
    @Binding var down: Bool
    private let segments = ["По цене", "По стажу", "По рейтингу"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<segments.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if selectedSegment == index {
                            // MARK: Тап по текущему — меняем направление стрелки
                            down.toggle()
                        } else {
                            // MARK: Выбран новый сегмент — сбрасываем вниз
                            selectedSegment = index
                            down = true
                        }
                    }
                }) {
                    HStack(spacing: 4) {
                        Text(segments[index])
                            .font(.system(size: 14, weight: .medium))
                        
                        // Иконка‑стрелка всегда в иерархии, но невидима вне активного сегмента
                        Image(systemName: "arrow.down")
                            .font(.system(size: 14, weight: .medium))
                            .rotationEffect(.degrees(down ? 0 : 180))
                            .opacity(selectedSegment == index ? 1 : 0)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundColor(selectedSegment == index ? .white : .gray)
                    .background(selectedSegment == index
                                ? Color(.systemPink)
                                : Color.white)
                }
                
                if index < segments.count - 1 {
                    Divider()
                        .frame(width: 1, height: 24)
                        .background(Color.gray.opacity(0.5))
                }
            }
        }
        // Общая анимация фоновых и цветовых изменений
        .animation(.easeInOut(duration: 0.3), value: selectedSegment)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
