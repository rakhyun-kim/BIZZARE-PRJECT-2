import SwiftUI

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

#Preview {
    PersonalInfoView(userInfo: nil)
} 