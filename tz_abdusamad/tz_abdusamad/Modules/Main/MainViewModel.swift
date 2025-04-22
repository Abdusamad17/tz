import SwiftUI

@Observable
class MainViewModel {
    var networkData: [User] = [] {
        didSet {
            defaultData = networkData.map {
                ArrItem(user: $0, isWritten: Bool.random())
            }
        }
    }
    var data: [ArrItem] = []
    var defaultData: [ArrItem] = [] {
        didSet {
            data = defaultData
            byPrice()
        }
    }
    
    let network = Network()
    
    init() {
        getData()
    }
}

extension MainViewModel {
    func getData() {
        networkData = network.getData()
    }
    
    func byPrice(down: Bool = true) {
        if down {
            data = defaultData
                .sorted { $0.user.home_price > $1.user.home_price }
        } else {
            data = defaultData
                .sorted { $0.user.home_price < $1.user.home_price }
        }
    }
    
    func byExperience(down: Bool = true) {
        if down {
            data = defaultData
                .sorted { $0.user.totalExperience > $1.user.totalExperience }
        } else {
            data = defaultData
                .sorted { $0.user.totalExperience < $1.user.totalExperience }
        }
    }
    
    func byRating(down: Bool = true) {
        if down {
            data = defaultData
                .sorted { $0.user.ratings_rating > $1.user.ratings_rating }
        } else {
            data = defaultData
                .sorted { $0.user.ratings_rating < $1.user.ratings_rating }
        }
    }
}

extension MainViewModel {
    func search(text: Binding<String>, currentFilter: Int, down: Bool) {
        let query = text.wrappedValue
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        guard !query.isEmpty else {
            switch currentFilter {
            case 1: byExperience(down: down)
            case 2: byRating(down: down)
            default: byPrice(down: down)
            }
            return
        }
        let filtered = defaultData.filter { item in
            let first = item.user.first_name.lowercased()
            let last  = item.user.last_name.lowercased()
            let patrony = item.user.patronymic.lowercased()
            return first.hasPrefix(query) || last.hasPrefix(query) || patrony.hasPrefix(query)
        }
        
        if currentFilter == 1 {
            if down {
                data = filtered.sorted {
                    $0.user.totalExperience > $1.user.totalExperience
                }
            } else {
                data = filtered.sorted {
                    $0.user.totalExperience < $1.user.totalExperience
                }
            }
        } else if currentFilter == 2 {
            if down {
                data = filtered.sorted {
                    $0.user.ratings_rating > $1.user.ratings_rating
                }
            } else {
                data = filtered.sorted {
                    $0.user.ratings_rating < $1.user.ratings_rating
                }
            }
        } else {
            if down {
                data = filtered.sorted {
                    $0.user.home_price > $1.user.home_price
                }
            } else {
                data = filtered.sorted {
                    $0.user.home_price < $1.user.home_price
                }
            }
        }
    }
}
