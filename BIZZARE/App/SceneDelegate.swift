import NaverThirdPartyLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            NaverThirdPartyLoginConnection.getSharedInstance().receiveAccessToken(url)
        }
    }
} 