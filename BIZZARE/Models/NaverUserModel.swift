struct NaverUserModel: Codable {
    let resultcode: String
    let message: String
    let response: NaverUserInfo
}

struct NaverUserInfo: Codable {
    let id: String
    let name: String?
    let nickname: String?
    let email: String?
    let gender: String?
    let age: String?
    let birthday: String?
    let profileImage: String?
    let birthyear: String?
    let mobile: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, nickname, email, gender, age, birthday
        case profileImage = "profile_image"
        case birthyear, mobile
    }
} 