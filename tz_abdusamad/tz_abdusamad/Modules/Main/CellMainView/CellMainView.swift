import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct CellMainView: View {
    @Binding var path: NavigationPath
    let id = UUID().uuidString
    let item: ArrItem
    let ratings_rating: Int
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                HStack(alignment: .top, spacing: 10) {
                    avatarImage
                    
                    VStack(alignment: .leading) {
                        Text(item.user.last_name)
                            .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black, colorBackGround: .clear))
                        Spacer()
                        
                        Text("\(item.user.first_name) \(item.user.patronymic)")
                            .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black, colorBackGround: .clear))
                        
                        Spacer()
                        ratings_ratingView
                        Spacer()
                        
                        HStack {
                            Text((item.user.specialization.isEmpty ? "специализация" : item.user.specialization[0].name)!)
                                .modifier(customText(sizeFont: 14, weightFont: .regular, colorText: .gray, colorBackGround: .clear))
                            
                            Text("\(item.user.totalExperience)")
                                .modifier(customText(sizeFont: 14, weightFont: .regular, colorText: .gray, colorBackGround: .clear))
                        }
                        
                        Spacer()
                        
                        Text("\(item.user.home_price)")
                            .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black, colorBackGround: .clear))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.clear)
                    
                    heartImage
                }
                .frame(maxHeight: .infinity)
            }
            .frame(height: 126)
            .background(.clear)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            
            Spacer()
            bookButton
        }
        .frame(height: 224)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal)
        .padding(.bottom)
    }
}

extension CellMainView {
    var ratings_ratingView: some View {
        HStack(alignment: .center) {
            if ratings_rating > 0 {
                ForEach(1...ratings_rating, id: \.self) { int in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.pink)
                }
            }
            if (ratings_rating <= 4) {
                ForEach((ratings_rating+1)...5, id: \.self) { int in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
    }
}

extension CellMainView {
    var bookButton: some View {
        Button {
            path.append(Path.desc(item))
        } label: {
            if item.isWritten {
                Text("Записаться")
                    .modifier(customText(sizeFont: 16, weightFont: .bold, colorText: .white, colorBackGround: .pink))
                    .frame(height: 47)
                    .frame(maxWidth: .infinity)
            } else {
                Text("Нет свободного расписания")
                    .modifier(customText(sizeFont: 16, weightFont: .bold, colorText: .black, colorBackGround: .gray))
                    .frame(height: 47)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(item.isWritten ? .pink : .gray)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
}

extension CellMainView {
    var heartImage: some View {
        VStack {
        Image(systemName: "heart")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(.gray)
            Spacer()
        }
        .background(.clear)
    }
}

extension CellMainView {
    var avatarImage: some View {
        VStack {
            if let url = URL(string: item.user.avatar ?? "") {
                WebImage(url: url)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipped()
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipped()
                    .clipShape(.circle)
            }
        }
        .background(.clear)
    }
}
