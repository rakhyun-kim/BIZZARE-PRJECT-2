import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingPaymentAlert = false
    @State private var isProcessingPayment = false
    
    var total: Double {
        productVM.cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                            
                            VStack(alignment: .leading) {
                                Text(item.product.name)
                                    .foregroundColor(.black)
                                Text(item.product.brand)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("$\(item.product.price, specifier: "%.2f")")
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            Stepper("Qty: \(item.quantity)", value: .init(
                                get: { item.quantity },
                                set: { productVM.updateCartItemQuantity(item: item, quantity: $0) }
                            ), in: 1...10)
                            .labelsHidden()
                        }
                    }
                    .onDelete(perform: productVM.removeFromCart)
                }
                
                if !productVM.cartItems.isEmpty {
                    VStack(spacing: 16) {
                        Divider()
                        
                        HStack {
                            Text("Total:")
                                .font(.headline)
                                .foregroundColor(.black)
                            Spacer()
                            Text("$\(total, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            isProcessingPayment = true
                            // 결제 처리 시뮬레이션
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isProcessingPayment = false
                                showingPaymentAlert = true
                            }
                        }) {
                            HStack {
                                if isProcessingPayment {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Image(systemName: "creditcard")
                                    Text("Pay $\(total, specifier: "%.2f")")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(isProcessingPayment)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .background(Color.white)
                }
            }
            .navigationTitle("Cart")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
        }
        .alert("Payment Successful", isPresented: $showingPaymentAlert) {
            Button("OK") {
                productVM.cartItems.removeAll()
                dismiss()
            }
        } message: {
            Text("Thank you for your purchase!")
        }
    }
}

#Preview {
    CartView()
        .environmentObject(ProductViewModel())
} 