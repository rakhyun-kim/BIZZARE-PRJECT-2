import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @State private var showingAddedToCart = false
    @State private var quantity = 1
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(maxHeight: 300)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.name)
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Text(product.brand)
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    Text(product.description)
                        .foregroundColor(.black)
                    
                    // 수량 선택기
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                        .padding(.vertical)
                    
                    Button(action: {
                        productVM.addToCart(product: product, quantity: quantity)
                        showingAddedToCart = true
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("Add to Cart")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            ToastView(message: "Added to cart!", isShowing: $showingAddedToCart)
                .animation(.easeInOut, value: showingAddedToCart)
        )
    }
}

// 토스트 메시지 뷰
struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowing = false
                }
            }
        }
    }
}

