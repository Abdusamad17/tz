import SwiftUI

struct СostOfServicesView: View {
    @State var viewModel = СostOfServicesViewModel()
    @State var model: ArrItem
    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            ServiceSection(
                title: "Видеоконсультация",
                leftText: "30 мин",
                rightText: "\(model.user.video_chat_price) ₽"
            )
            
            ServiceSection(
                title: "Чат с врачом",
                leftText: "30 мин",
                rightText: "\(model.user.text_chat_price) ₽"
            )
            
            ServiceSection(
                title: "Приём в клинике",
                leftText: "В клинике",
                rightText: "\(model.user.hospital_price) ₽"
            )
            
            Spacer()
        }
        .padding(.top, 16)
        .background(Color(.systemGray6))
        .navigationTitle("Стоимость услуг")
    }
}

fileprivate struct ServiceSection: View {
    let title: String
    let leftText: String
    let rightText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)
            
            HStack {
                Text(leftText)
                Spacer()
                Text(rightText)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 16)
        }
    }
}
