import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            SwipeView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "flame")
                }
                .tag(0)
            MatchView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "bubble.right")
                }
                .tag(1)
            ProfileView(user: user, editMode: true)
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User.mockUsers[0])
    }
}
