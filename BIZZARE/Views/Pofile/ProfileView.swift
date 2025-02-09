import SwiftUI

struct ProfileView: View {
    @StateObject private var naverAuthVM = NaverAuthViewModel()
    @State private var isLoggedIn = false
    @State private var selectedTab = "주문내역"
    let tabs = ["주문내역", "개인정보", "설정"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isLoggedIn {
                    ScrollView {
                        VStack(spacing: 20) {
                            // 프로필 헤더
                            HStack(spacing: 20) {
                                if let profileImage = naverAuthVM.userInfo?.profileImage,
                                   let url = URL(string: profileImage) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(.gray)
                                    }
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.gray)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(naverAuthVM.userInfo?.name ?? naverAuthVM.userInfo?.nickname ?? "사용자")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    if let email = naverAuthVM.userInfo?.email {
                                        Text(email)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.05), radius: 5)
                            
                            // 탭 선택 버튼
                            HStack {
                                ForEach(tabs, id: \.self) { tab in
                                    Button(action: {
                                        selectedTab = tab
                                    }) {
                                        VStack(spacing: 8) {
                                            Text(tab)
                                                .foregroundColor(selectedTab == tab ? .black : .gray)
                                                .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular))
                                            
                                            Rectangle()
                                                .fill(selectedTab == tab ? Color.black : Color.clear)
                                                .frame(height: 2)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal)
                            
                            // 선택된 탭에 따른 컨텐츠
                            switch selectedTab {
                            case "주문내역":
                                OrderHistoryView()
                            case "개인정보":
                                PersonalInfoView(userInfo: naverAuthVM.userInfo)
                            case "설정":
                                SettingsView(onLogout: {
                                    naverAuthVM.logout()
                                    isLoggedIn = false
                                })
                            default:
                                EmptyView()
                            }
                        }
                        .padding()
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