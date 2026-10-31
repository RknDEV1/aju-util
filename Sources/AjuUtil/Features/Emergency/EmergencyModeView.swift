import SwiftUI
import SwiftUIKit

/// Full-screen style list focused only on emergency numbers.
struct EmergencyModeView: View {
    let items: [UtilityItem]

    private var emergency: [UtilityItem] {
        items.filter { $0.category == .emergency }
    }

    var body: some View {
        List {
            Section {
                Text("Toque para ligar. Em risco imediato, use 190, 192 ou 193.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Section("Números de emergência") {
                ForEach(emergency) { item in
                    Button {
                        call(item.phone)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text(item.summary)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            Spacer()
                            if let phone = item.phone {
                                Text(phone)
                                    .font(.title3.weight(.bold))
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Modo emergência")
    }

    private func call(_ phone: String?) {
        guard let phone else { return }
        let cleaned = phone.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}
