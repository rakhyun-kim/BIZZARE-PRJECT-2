import SwiftUI

struct CartView: View {
    @EnvironmentObject var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    var total: Double {
        productVM.cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    var body: some View {
        NavigationView {
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
                        
                        VStack(alignment: .leading) {
                            Text(item.product.name)
                                .foregroundColor(.black)
                            Text("$\(item.product.price, specifier: "%.2f")")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("x\(item.quantity)")
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Cart")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
            
            if !productVM.cartItems.isEmpty {
                VStack {
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
                    .padding()
                    
                    Button(action: {
                        // Implement checkout
                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(ProductViewModel())
} 