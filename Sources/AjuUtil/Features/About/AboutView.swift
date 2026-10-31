import SwiftUI
import SwiftToolkit
import SwiftUIKit

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(
                    "Aju Util",
                    subtitle: "Utilidade para Aracaju e Grande Aracaju"
                )

                Text("App nativo em SwiftUI com contatos e links úteis. Os dados principais vêm de um JSON local e podem ser usados offline.")
                    .foregroundStyle(.secondary)

                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Aviso importante")
                            .font(.headline)
                        Text("Telefones e sites podem mudar. Em emergência, use os números nacionais (190, 192, 193, 199). Confirme sempre informações críticas nos canais oficiais da Prefeitura e do Estado.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Text("Feito com swift-toolkit e swift-ui-kit · Open source")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Versão do pacote: \(Bundle.main.versionLabel)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle("Sobre")
    }
}
