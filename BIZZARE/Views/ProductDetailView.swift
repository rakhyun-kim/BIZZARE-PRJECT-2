import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
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
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    Text(product.description)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        productVM.addToCart(product: product)
                    }) {
                        Text("Add to Cart")
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
    }
}

#Preview {
    NavigationView {
        ProductDetailView(product: Product(
            id: 1,
            name: "Sample Product",
            price: 29.99,
            description: "Sample description",
            imageUrl: "https://example.com/sample.jpg",
            category: "SALE",
            isOnSale: true
        ))
        .environmentObject(ProductViewModel())
    }
} 
