import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cartItems: [CartItem] = []
    @Published var orders: [Order] = []
    @Published var selectedCategory: Category = .all
    
    init() {
        loadProducts()
    }
    
    var filteredProducts: [Product] {
        switch selectedCategory {
        case .all:
            return products
        case .sale:
            return products.filter({ $0.isOnSale })
        default:
            return products.filter({ $0.category == selectedCategory.rawValue })
        }
    }
    
    func loadProducts() {
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(ProductResponse.self, from: data)
                self.products = response.products
            } catch {
                print("Error loading products: \(error)")
            }
        }
    }
    
    func addToCart(product: Product, quantity: Int = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    func updateCartItemQuantity(item: CartItem, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity = quantity
        }
    }
    
    func removeFromCart(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
    
    var cartItemsCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    func filteredProducts(for brandCategory: String? = nil) -> [Product] {
        if let brandCategory = brandCategory {
            return products.filter { $0.brand == brandCategory }
        }
        
        switch selectedCategory {
        case .all:
            return products
        case .sale:
            return products.filter({ $0.isOnSale })
        case .brands:
            return []  // 브랜드 카테고리에서는 브랜드 목록을 보여주므로 상품은 비움
        default:
            return products.filter({ $0.category == selectedCategory.rawValue })
        }
    }
    
    func createOrder() {
        let newOrder = Order(
            items: cartItems,
            totalAmount: cartItems.reduce(0) { $0 + ($1.product.price * $1.quantity) }
        )
        orders.append(newOrder)
        cartItems.removeAll()
    }
} 