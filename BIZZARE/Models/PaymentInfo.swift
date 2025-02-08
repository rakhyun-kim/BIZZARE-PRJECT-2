import Foundation

struct PaymentInfo {
    var cardNumber: String = ""
    var expiryDate: String = ""
    var cvv: String = ""
    var name: String = ""
    var address: String = ""
    
    var isValid: Bool {
        !cardNumber.isEmpty && cardNumber.count == 16 &&
        !expiryDate.isEmpty && expiryDate.count == 5 &&
        !cvv.isEmpty && cvv.count == 3 &&
        !name.isEmpty &&
        !address.isEmpty
    }
} 