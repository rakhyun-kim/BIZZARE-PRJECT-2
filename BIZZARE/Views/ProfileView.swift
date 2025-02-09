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

// 주문 내역 뷰
struct OrderHistoryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("최근 주문 내역")
                .font(.headline)
                .padding(.top)
            
            if true { // 주문 내역이 없는 경우
                VStack(spacing: 10) {
                    Image(systemName: "bag")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("주문 내역이 없습니다")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

// 개인 정보 뷰
struct PersonalInfoView: View {
    let userInfo: NaverUserInfo?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
                InfoRow(title: "이름", value: userInfo?.name ?? "미설정")
                InfoRow(title: "이메일", value: userInfo?.email ?? "미설정")
                if let gender = userInfo?.gender {
                    InfoRow(title: "성별", value: gender == "M" ? "남성" : "여성")
                }
                if let age = userInfo?.age {
                    InfoRow(title: "연령대", value: age)
                }
                if let birthday = userInfo?.birthday {
                    InfoRow(title: "생일", value: birthday)
                }
                if let mobile = userInfo?.mobile {
                    InfoRow(title: "전화번호", value: mobile)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .foregroundColor(.black)
            Spacer()
        }
    }
}

// 설정 뷰
struct SettingsView: View {
    let onLogout: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {}) {
                SettingRow(title: "알림 설정", icon: "bell")
            }
            
            Button(action: {}) {
                SettingRow(title: "배송지 관리", icon: "location")
            }
            
            Button(action: {}) {
                SettingRow(title: "결제 수단 관리", icon: "creditcard")
            }
            
            Divider()
            
            Button(action: onLogout) {
                HStack {
                    Text("로그아웃")
                        .foregroundColor(.red)
                    Spacer()
                    Image(systemName: "arrow.right.square")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
            }
        }
    }
}

struct SettingRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

#Preview {
    ProfileView()
} 