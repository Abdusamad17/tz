import SwiftUI

struct CustomSearchBar: View {
    @Binding var serachText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(CustomColors.lightkGray)
                .background(.white)
                .padding(.leading, 8)
            
            TextField("Поиск", text: $serachText)
                .padding(8)
                .background(.white)
                .tint(CustomColors.lightkGray)
                .foregroundColor(.black)
                .cornerRadius(8)
                .padding(.trailing, 8)
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal)
        
    }
}
