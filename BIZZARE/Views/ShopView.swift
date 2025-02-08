import SwiftUI

struct ShopView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @State private var showingCart = false
    @State private var showingSearch = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 카테고리 스크롤 뷰
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button(action: {
                                withAnimation {
                                    productVM.selectedCategory = category
                                }
                            }) {
                                Text(category.rawValue)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(productVM.selectedCategory == category ? .white : .black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        productVM.selectedCategory == category ?
                                            Color.black : Color.clear
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                
                // 상품 그리드
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(productVM.filteredProducts) { product in
                            ProductCard(product: product)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Shop")
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
                
                Button(action: { showingCart.toggle() }) {
                    Image(systemName: "cart")
                        .foregroundColor(.black)
                }
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
    ShopView()
        .environmentObject(ProductViewModel())
} 