import SwiftUI

struct ProfileView: View {
    @StateObject private var naverAuthVM = NaverAuthViewModel()
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoggedIn {
                    // 로그인된 상태의 UI
                    VStack(spacing: 16) {
                        if let profileImage = naverAuthVM.userInfo?.profileImage,
                           let url = URL(string: profileImage) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                        
                        Text(naverAuthVM.userInfo?.name ?? naverAuthVM.userInfo?.nickname ?? "사용자")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let email = naverAuthVM.userInfo?.email {
                            Text(email)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            naverAuthVM.logout()
                            isLoggedIn = false
                        }) {
                            Text("로그아웃")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    // 로그인되지 않은 상태의 UI
                    VStack(spacing: 16) {
                        Text("Sign in to your account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Button(action: {
                            naverAuthVM.login()
                        }) {
                            HStack {
                                Image("naver_logo")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("네이버로 로그인")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .onReceive(naverAuthVM.$userInfo) { userInfo in
            isLoggedIn = userInfo != nil
        }
    }
}

#Preview {
    ProfileView()
} 