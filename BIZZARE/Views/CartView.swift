import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var productVM: ProductViewModel
    @State private var showingPaymentAlert = false
    @State private var isProcessingPayment = false
    
    var body: some View {
        NavigationView {
            VStack {
                if productVM.cartItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "cart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("장바구니가 비어있습니다")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(productVM.cartItems) { item in
                            HStack {
                                AsyncImage(url: URL(string: item.product.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.product.name)
                                        .font(.headline)
                                    Text("$\(item.product.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                // 수량 조절 컨트롤
                                HStack(spacing: 12) {
                                    Button(action: {
                                        if item.quantity > 1 {
                                            productVM.updateCartItemQuantity(item: item, quantity: item.quantity - 1)
                                        }
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(item.quantity > 1 ? .black : .gray)
                                    }
                                    .disabled(item.quantity <= 1)
                                    
                                    Text("\(item.quantity)")
                                        .font(.system(.headline, design: .monospaced))
                                        .frame(minWidth: 30)
                                    
                                    Button(action: {
                                        productVM.updateCartItemQuantity(item: item, quantity: item.quantity + 1)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: productVM.removeFromCart)
                        
                        Section {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text("$\(totalPrice, specifier: "%.2f")")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    Button(action: {
                        isProcessingPayment = true
                        // 결제 처리 시뮬레이션
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            productVM.createOrder()  // 주문 생성
                            isProcessingPayment = false
                            showingPaymentAlert = true
                        }
                    }) {
                        HStack {
                            if isProcessingPayment {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("결제하기")
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    .disabled(isProcessingPayment)
                    .padding()
                }
            }
            .navigationTitle("Cart")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
            .alert("결제 완료", isPresented: $showingPaymentAlert) {
                Button("확인") {
                    productVM.cartItems.removeAll()
                    dismiss()
                }
            } message: {
                Text("결제가 성공적으로 완료되었습니다.")
            }
        }
    }
    
    private var totalPrice: Double {
        productVM.cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}

#Preview {
    CartView()
        .environmentObject(ProductViewModel())
} 