import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading) {
                            Text("Guest User")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Sign in to your account")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Section("Account") {
                    NavigationLink(destination: EmptyView()) {
                        Label("Orders", systemImage: "bag")
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: EmptyView()) {
                        Label("Settings", systemImage: "gear")
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: EmptyView()) {
                        Label("Help", systemImage: "questionmark.circle")
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
} 