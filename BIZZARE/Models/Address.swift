import Foundation

struct Address: Identifiable, Codable {
    let id: UUID
    var name: String
    var recipient: String
    var phoneNumber: String
    var zipCode: String
    var address1: String
    var address2: String
    var isDefault: Bool
    
    init(id: UUID = UUID(), name: String = "", recipient: String = "", phoneNumber: String = "", zipCode: String = "", address1: String = "", address2: String = "", isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.recipient = recipient
        self.phoneNumber = phoneNumber
        self.zipCode = zipCode
        self.address1 = address1
        self.address2 = address2
        self.isDefault = isDefault
    }
} 