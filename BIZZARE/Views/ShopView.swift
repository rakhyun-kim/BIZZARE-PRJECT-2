import SwiftUI

struct ShopView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @State private var showingCart = false
    @State private var showingSearch = false
    @State private var selectedBrand: Brand?
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
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
            VStack(spacing: 0) {
                // 카테고리 스크롤 뷰
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button(action: {
                                withAnimation {
                                    productVM.selectedCategory = category
                                    selectedBrand = nil
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
                
                if productVM.selectedCategory == .brands && selectedBrand == nil {
                    // 브랜드 목록 표시
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Brand.brands) { brand in
                                Button(action: {
                                    selectedBrand = brand
                                }) {
                                    Text(brand.name)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    // 선택된 카테고리 표시
                    HStack {
                        Text(selectedBrand?.name ?? productVM.selectedCategory.rawValue)
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        Text("\(productVM.filteredProducts.count) items")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    // 상품 그리드
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(productVM.filteredProducts(for: selectedBrand?.category)) { product in
                                ProductCard(product: product)
                            }
                        }
                        .padding()
                    }
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
    ShopView()
        .environmentObject(ProductViewModel())
} 