import Foundation

class Network {
    func getData() -> [User] {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
            fatalError("No file test.json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let recordData = try JSONDecoder().decode(RecordData.self, from: data)
            return recordData.data.users
        } catch {
            print("ERROR IN NETWORK!")
            print(error.localizedDescription)
        }
        
        return []
    }
}
