import SwiftUI

struct MainTabView: View {
    @StateObject private var productVM = ProductViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(productVM)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ShopView()
                .environmentObject(productVM)
                .tabItem {
                    Label("Shop", systemImage: "bag")
                }
            
            ProfileView()
                .environmentObject(productVM)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView()
} 