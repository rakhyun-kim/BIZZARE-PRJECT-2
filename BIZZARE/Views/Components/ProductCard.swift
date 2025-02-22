import SwiftUI

struct ProductCard: View {
    let product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            VStack(alignment: .leading, spacing: 8) {
                // 이미지
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: UIScreen.main.bounds.width / 2.4, height: UIScreen.main.bounds.width / 2.4)
                .clipped()
                
                // 상품 정보
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(product.brand)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if product.isOnSale {
                            Text("SALE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                    }
                    
                    Text(product.name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text("₩\(product.price)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width / 2.4, height: UIScreen.main.bounds.width / 1.8)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}
