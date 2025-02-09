import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if productVM.orders.isEmpty {
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
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(productVM.orders.sorted(by: { $0.orderDate > $1.orderDate })) { order in
                            OrderCard(order: order)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct OrderCard: View {
    let order: Order
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 주문 헤더
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("주문번호: \(order.id.uuidString.prefix(8))")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(order.orderDate.formatted())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(order.orderStatus.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Divider()
            
            // 주문 요약
            HStack {
                Text("총 \(order.items.count)개 상품")
                    .font(.subheadline)
                Spacer()
                Text("₩\(order.totalAmount)")
                    .font(.headline)
            }
            
            // 상세 내역 (확장 시)
            if isExpanded {
                Divider()
                ForEach(order.items) { item in
                    HStack {
                        Text(item.product.name)
                            .font(.subheadline)
                        Spacer()
                        Text("\(item.quantity)개")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("₩\(item.product.price * item.quantity)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
} 