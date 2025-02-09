import Foundation

struct Product: Identifiable, Codable {
    let id: UUID
    let name: String
    let price: Int
    let brand: String
    let description: String
    let imageUrl: String
    let category: String
    let isOnSale: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case brand
        case description
        case imageUrl
        case category
        case isOnSale
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // ID를 문자열로 디코딩한 후 UUID로 변환
        if let idString = try? container.decode(String.self, forKey: .id) {
            self.id = UUID(uuidString: idString) ?? UUID()
        } else {
            self.id = UUID()
        }
        
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Int.self, forKey: .price)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.category = try container.decode(String.self, forKey: .category)
        self.isOnSale = try container.decode(Bool.self, forKey: .isOnSale)
    }
    
    init(id: UUID = UUID(), name: String, price: Int, brand: String, description: String = "", imageUrl: String = "", category: String = "", isOnSale: Bool = false) {
        self.id = id
        self.name = name
        self.price = price
        self.brand = brand
        self.description = description
        self.imageUrl = imageUrl
        self.category = category
        self.isOnSale = isOnSale
    }
} 