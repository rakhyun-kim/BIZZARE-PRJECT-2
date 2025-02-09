import SwiftUI

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

#Preview {
    OrderHistoryView()
} 