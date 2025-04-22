import SwiftUI
import SDWebImageSwiftUI

struct DescriptionView: View {
    @State var model: ArrItem
    @Binding var path: NavigationPath
    let mainViewModel: MainViewModel
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            infoSection
            priceSection
            descText
            Spacer()
            bookButton
        }
        .frame(maxWidth: .infinity)
        .background(CustomColors.gray)
        .navigationTitle("Педиатр")
    }
}

private extension DescriptionView {
    
    var headerView: some View {
        HStack(spacing: 10) {
            if let url = URL(string: model.user.avatar ?? "") {
                WebImage(url: url)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipped()
                    .clipShape(.circle)
                    .background(.clear)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipped()
                    .clipShape(.circle)
                    .background(.clear)
            }
            VStack(alignment: .leading) {
                Text(model.user.last_name)
                    .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black))
                Text("\(model.user.first_name) \(model.user.patronymic)")
                    .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black))
            }
            Spacer()
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
    
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            tempHStack(image: "clock",          label: "\(model.user.totalExperience)")
            tempHStack(image: "person",         label: model.user.education_type_label?.name ?? "—")
            tempHStack(image: "graduationcap",  label: model.user.scientific_degree_label)
            tempHStack(image: "mappin",         label: "МГУ имени М. В. Ломоносова")
        }
        .padding(.horizontal)
    }
    
    var priceSection: some View {
        HStack(alignment: .center) {
            Text("Стоимость услуг")
                .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black, colorBackGround: .clear))
                .padding(.leading)
            
            Spacer()
            
            Text("от \(model.user.home_price) ₽")
                .modifier(customText(sizeFont: 16, weightFont: .medium, colorText: .black, colorBackGround: .clear))
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding()
    }
    
    var descText: some View {
        Text("Проводит диагностику и лечение терапевтических больных. Осуществляет расшифровку и снятие ЭКГ. Дает рекомендации по диетологии. Доктор имеет опыт работы в России и зарубежом. Проводит консультации пациентов на английском языке.")
            .modifier(customText(sizeFont: 14, weightFont: .regular, colorText: .black, colorBackGround: .clear))
            .padding(.horizontal)
    }
    
    var bookButton: some View {
        Button {
            if model.isWritten {
                path.append(Path.cost(model))
                model.isWritten.toggle()
                change(id: model.user.id)
            }
        } label: {
            Text(model.isWritten ? "Записаться" : "Нет свободного расписания")
                .modifier(customText(sizeFont: 16, weightFont: .bold, colorText: .white))
                .frame(height: 56)
                .frame(maxWidth: .infinity)
        }
        .background(model.isWritten ? Color.pink : Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
}

struct tempHStack: View {
    let image: String
    let label: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Image(systemName: image)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(CustomColors.darkGray)
                .scaledToFit()
                .clipped()
            
            Text(label)
                .modifier(customText(sizeFont: 14, weightFont: .medium, colorText: CustomColors.darkGray))
                .frame(height: 24)
        }
    }
}

extension DescriptionView {
    private func change(id: String) {
        if let i = mainViewModel.data.firstIndex(where: { $0.user.id == id }) {
            mainViewModel.data[i].isWritten.toggle()
        }
    }
}

