import SwiftUI

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
    SettingsView(onLogout: {})
} 