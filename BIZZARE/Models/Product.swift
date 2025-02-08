struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let price: Double
    let description: String
    let imageUrl: String
    let category: String
    let isOnSale: Bool
} 