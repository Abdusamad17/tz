import SwiftUI

struct TabBar: View {
    @State var selectModule: String = "house.fill"
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView(selection: $selectModule) {
            MainView()
                .tag("house.fill")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
            
            Text("Приёмы")
                .tag("list.bullet.clipboard")
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Приёмы")
                }
            
            Text("Чат")
                .tag("message.fill")
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Чат")
                }
            
            Text("Профиль")
                .tag("person.fill")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
                }
        }
        .tint(.pink)  
    }
}

#Preview {
    TabBar()
}
