import SwiftUI

struct MainView: View {
    @State var viewModel: MainViewModel = .init()
    @State var path = NavigationPath()
    @State var serachText: String = ""
    @State var currentFilter: Int = 0
    @State var down = true
    let nameOfTheProfession = "Педиатры"
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical) {
                Text(nameOfTheProfession)
                    .font(.system(size: 20))
                
                CustomSearchBar(serachText: $serachText)
                    .padding(.top)
                    .onChange(of: serachText) { _, newValue in
                        if newValue == "" || newValue.count == 0 {
                            switch currentFilter {
                            case 0: viewModel.byPrice(down: down)
                            case 1: viewModel.byExperience(down: down)
                            case 2: viewModel.byRating(down: down)
                            default: viewModel.byPrice(down: down)
                            }
                        } else {
                            self.viewModel.search(text: $serachText, currentFilter: currentFilter, down: down)
                        }
                      }
                
                CustomSegmentedControll(selectedSegment: $currentFilter, down: $down)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                
                VStack {
                    ForEach(viewModel.data, id: \.user.id) { item in
                      CellMainView(
                        path: $path,
                        item: item,
                        ratings_rating: Int(item.user.ratings_rating)
                      )
                    }
                  }
                  .frame(maxWidth: .infinity)
                  .background(CustomColors.gray)
            }
            .background(CustomColors.gray)
            .scrollIndicators(.hidden, axes: .vertical)
            .onChange(of: currentFilter) { _, newIndex in
                if serachText == "" || serachText.count == 0 {
                    switch newIndex {
                    case 0: viewModel.byPrice(down: down)
                    case 1: viewModel.byExperience(down: down)
                    case 2: viewModel.byRating(down: down)
                    default: break
                    }
                } else {
                    self.viewModel.search(text: $serachText, currentFilter: currentFilter, down: down)
                }
            }
            .onChange(of: down) { _, newIndex in
                if serachText == "" || serachText.count == 0 {
                    switch currentFilter {
                    case 0: viewModel.byPrice(down: down)
                    case 1: viewModel.byExperience(down: down)
                    case 2: viewModel.byRating(down: down)
                    default: break
                    }
                } else {
                    self.viewModel.search(text: $serachText, currentFilter: currentFilter, down: down)
                }
            }
            .navigationDestination(for: Path.self) { str in
                switch str {
                case .desc(let model):
                    DescriptionView(model: model, path: $path, mainViewModel: viewModel)
                case .cost(let model):
                    СostOfServicesView(model: model, path: $path)
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func cellView(for model: ArrItem, isWritten: Bool) -> some View {
        CellMainView(path: self.$path, item: model, ratings_rating: Int(model.user.ratings_rating))
    }
}


enum Path: Hashable {
    case desc(ArrItem)
    case cost(ArrItem)
}

#Preview {
    MainView()
}
