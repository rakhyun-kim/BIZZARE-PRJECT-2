import SwiftUI

class AddressViewModel: ObservableObject {
    @Published var addresses: [Address] = []
    
    func addAddress(_ address: Address) {
        if address.isDefault {
            // 새로운 기본 배송지가 설정되면 기존 기본 배송지 해제
            addresses = addresses.map { addr in
                var updatedAddr = addr
                updatedAddr.isDefault = false
                return updatedAddr
            }
        }
        addresses.append(address)
    }
    
    func updateAddress(_ address: Address) {
        if let index = addresses.firstIndex(where: { $0.id == address.id }) {
            if address.isDefault {
                // 새로운 기본 배송지가 설정되면 기존 기본 배송지 해제
                addresses = addresses.map { addr in
                    var updatedAddr = addr
                    updatedAddr.isDefault = false
                    return updatedAddr
                }
            }
            addresses[index] = address
        }
    }
    
    func removeAddress(at indexSet: IndexSet) {
        addresses.remove(atOffsets: indexSet)
    }
}

struct AddressManagementView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddressViewModel()
    @State private var showingAddAddress = false
    @State private var editingAddress: Address?
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.addresses.isEmpty {
                    Text("등록된 배송지가 없습니다")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.addresses) { address in
                        AddressRow(address: address) {
                            editingAddress = address
                        }
                    }
                    .onDelete(perform: viewModel.removeAddress)
                }
            }
            .navigationTitle("배송지 관리")
            .navigationBarItems(
                leading: Button("닫기") { dismiss() },
                trailing: Button(action: { showingAddAddress = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddAddress) {
                AddressFormView(viewModel: viewModel)
            }
            .sheet(item: $editingAddress) { address in
                AddressFormView(viewModel: viewModel, editingAddress: address)
            }
        }
    }
}

struct AddressRow: View {
    let address: Address
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(address.name)
                    .font(.headline)
                if address.isDefault {
                    Text("기본 배송지")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(4)
                }
                Spacer()
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
            }
            
            Text(address.recipient)
                .font(.subheadline)
            Text(address.phoneNumber)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(address.zipCode)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(address.address1)
                .font(.subheadline)
            if !address.address2.isEmpty {
                Text(address.address2)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}

struct AddressFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddressViewModel
    @State private var address: Address
    let editingAddress: Address?
    
    init(viewModel: AddressViewModel, editingAddress: Address? = nil) {
        self.viewModel = viewModel
        self.editingAddress = editingAddress
        _address = State(initialValue: editingAddress ?? Address())
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("배송지 정보")) {
                    TextField("배송지명", text: $address.name)
                    TextField("받는 사람", text: $address.recipient)
                    TextField("전화번호", text: $address.phoneNumber)
                        .keyboardType(.phonePad)
                }
                
                Section(header: Text("주소")) {
                    TextField("우편번호", text: $address.zipCode)
                        .keyboardType(.numberPad)
                    TextField("기본주소", text: $address.address1)
                    TextField("상세주소", text: $address.address2)
                }
                
                Section {
                    Toggle("기본 배송지로 설정", isOn: $address.isDefault)
                }
            }
            .navigationTitle(editingAddress == nil ? "배송지 추가" : "배송지 수정")
            .navigationBarItems(
                leading: Button("취소") { dismiss() },
                trailing: Button("저장") {
                    if editingAddress != nil {
                        viewModel.updateAddress(address)
                    } else {
                        viewModel.addAddress(address)
                    }
                    dismiss()
                }
                .disabled(address.name.isEmpty || address.recipient.isEmpty || 
                         address.phoneNumber.isEmpty || address.address1.isEmpty)
            )
        }
    }
}

#Preview {
    AddressManagementView()
} 