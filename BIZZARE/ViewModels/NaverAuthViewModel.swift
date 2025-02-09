import NaverThirdPartyLogin
import Foundation

class NaverAuthViewModel: NSObject, ObservableObject {
    
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    @Published var userInfo: NaverUserInfo?
    
    override init() {
        super.init()
        instance?.delegate = self
    }
    
    func login() {
        instance?.requestThirdPartyLogin()
    }
    
    func logout() {
        instance?.requestDeleteToken()
        DispatchQueue.main.async {
            self.userInfo = nil
        }
    }
    
    func getNaverInfo() {
        guard let isValidAccessToken = instance?.isValidAccessTokenExpireTimeNow() else { return }
        guard isValidAccessToken else {
            print("토큰이 만료되었습니다. 재로그인이 필요합니다.")
            return
        }
        
        guard let tokenType = instance?.tokenType,
              let accessToken = instance?.accessToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        guard let url = URL(string: urlStr) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("에러 발생: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("데이터가 없습니다.")
                return
            }
            
            // 디버깅을 위한 JSON 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("받은 JSON 데이터:", jsonString)
            }
            
            do {
                let naverUser = try JSONDecoder().decode(NaverUserModel.self, from: data)
                DispatchQueue.main.async {
                    self?.userInfo = naverUser.response
                    print("로그인 성공!")
                    print("이메일: \(naverUser.response.email ?? "없음")")
                    print("이름: \(String(describing: naverUser.response.name))")
                    print("닉네임: \(String(describing: naverUser.response.nickname))")
                }
            } catch {
                print("디코딩 에러: \(error)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("키를 찾을 수 없음: \(key), context: \(context)")
                    case .valueNotFound(let type, let context):
                        print("값을 찾을 수 없음: \(type), context: \(context)")
                    case .typeMismatch(let type, let context):
                        print("타입 불일치: \(type), context: \(context)")
                    case .dataCorrupted(let context):
                        print("데이터 손상: \(context)")
                    @unknown default:
                        print("알 수 없는 디코딩 에러")
                    }
                }
            }
        }.resume()
    }
}

extension NaverAuthViewModel: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인 성공")
        getNaverInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("네이버 토큰 갱신 성공")
        getNaverInfo()
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃 성공")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러 발생: \(error.localizedDescription)")
    }
} 
