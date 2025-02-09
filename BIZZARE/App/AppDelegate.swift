import SwiftUI
import NaverThirdPartyLogin

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱으로 인증하는 방식 활성화
        instance?.isNaverAppOauthEnable = true
        // SafariViewController에서 인증하는 방식 활성화
        instance?.isInAppOauthEnable = true
        // 인증 화면을 iPhone의 세로 모드에서만 활성화
        instance?.setOnlyPortraitSupportInIphone(true)
        
        // 로그인 설정
        instance?.serviceUrlScheme = "BIZZARE.BIZZARE" // URL Scheme
        instance?.consumerKey = "hvE1hG1Djknh_f4dZLbH" // 클라이언트 아이디
        instance?.consumerSecret = "x6aVm1iOov" // 클라이언트 시크릿
        instance?.appName = "BIZZARE" // 앱 이름
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        return true
    }
} 