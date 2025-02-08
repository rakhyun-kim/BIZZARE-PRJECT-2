import SwiftUI

struct ProductCard: View {
    let product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            VStack {
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipped()
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}

#Preview {
    ProductCard(product: Product(
        id: 1,
        name: "Sample Product",
        price: 29.99,
        brand: "Sample Brand",
        description: "Sample description",
        imageUrl: "https://example.com/sample.jpg",
        category: "Sample",
        isOnSale: false
    ))
    .environmentObject(ProductViewModel())
} 
