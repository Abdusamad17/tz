import SwiftUI

struct customText: ViewModifier {
    var sizeFont: CGFloat
    var weightFont: Font.Weight = .regular
    var colorText: Color = .white
    var colorBackGround: Color = .clear
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: sizeFont, weight: weightFont))
            .foregroundStyle(colorText)
            .background(colorBackGround)
    }
}
