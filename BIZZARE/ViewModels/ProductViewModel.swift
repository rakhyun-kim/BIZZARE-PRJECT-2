import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cartItems: [CartItem] = []
    @Published var selectedCategory: Category = .all
    
    init() {
        loadProducts()
    }
    
    var filteredProducts: [Product] {
        switch selectedCategory {
        case .all:
            return products
        case .sale:
            return products.filter { $0.isOnSale }
        default:
            return products.filter { $0.category == selectedCategory.rawValue }
        }
    }
    
    func loadProducts() {
        // JSON 파일에서 상품 데이터 로드
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                products = try decoder.decode([Product].self, from: data)
            } catch {
                print("Error loading products: \(error)")
            }
        }
    }
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
} 