import SwiftUI

struct HomeView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @State private var showingCart = false
    @State private var showingSearch = false
    
    var cartButton: some View {
        Button(action: { showingCart.toggle() }) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .foregroundColor(.black)
                
                if productVM.cartItemsCount > 0 {
                    Text("\(productVM.cartItemsCount)")
                        .font(.caption2)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Featured Products
                    Text("Featured")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(productVM.products.prefix(5)) { product in
                                ProductCard(product: product)
                            }
                        }
                    }
                    
                    // New Arrivals
                    Text("New Arrivals")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(productVM.products.prefix(4)) { product in
                            ProductCard(product: product)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("BIZZARE")
            .navigationBarItems(trailing: HStack(spacing: 16) {
                Button(action: { 
                    withAnimation {
                        showingSearch.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                
                cartButton
            })
        }
        .sheet(isPresented: $showingCart) {
            CartView()
                .environmentObject(productVM)
        }
        .sheet(isPresented: $showingSearch) {
            SearchView()
                .environmentObject(productVM)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ProductViewModel())
} 