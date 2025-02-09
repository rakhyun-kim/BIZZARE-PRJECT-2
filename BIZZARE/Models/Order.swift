import Foundation

struct Order: Identifiable, Codable {
    let id: UUID
    let items: [CartItem]
    let totalAmount: Int
    let orderDate: Date
    let orderStatus: OrderStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case items
        case totalAmount
        case orderDate
        case orderStatus
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.items = try container.decode([CartItem].self, forKey: .items)
        self.totalAmount = try container.decode(Int.self, forKey: .totalAmount)
        self.orderDate = try container.decode(Date.self, forKey: .orderDate)
        self.orderStatus = try container.decode(OrderStatus.self, forKey: .orderStatus)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(items, forKey: .items)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(orderDate, forKey: .orderDate)
        try container.encode(orderStatus, forKey: .orderStatus)
    }
    
    init(id: UUID = UUID(), items: [CartItem], totalAmount: Int, orderDate: Date = Date(), orderStatus: OrderStatus = .pending) {
        self.id = id
        self.items = items
        self.totalAmount = totalAmount
        self.orderDate = orderDate
        self.orderStatus = orderStatus
    }
}

enum OrderStatus: String, Codable {
    case pending = "주문 접수"
    case processing = "처리중"
    case shipping = "배송중"
    case completed = "배송완료"
    case cancelled = "취소됨"
} 
