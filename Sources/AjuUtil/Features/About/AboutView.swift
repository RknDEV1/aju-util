import SwiftUI
import SwiftToolkit
import SwiftUIKit

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(
                    "Aju Util",
                    subtitle: "Feito para Aracaju e Grande Aracaju"
                )

                Text("App nativo em SwiftUI com contatos e links úteis. Os dados principais ficam em JSON local e funcionam offline.")
                    .foregroundStyle(.secondary)

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("O que o app faz", systemImage: "checkmark.circle")
                            .font(.headline)
                        bullet("Buscar contatos e serviços")
                        bullet("Ligar e abrir sites oficiais")
                        bullet("Modo emergência e mapa de pontos")
                        bullet("Favoritos e compartilhamento")
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Aviso importante")
                            .font(.headline)
                        Text("Telefones e sites podem mudar. Em emergência, use 190, 192, 193 ou 199. Confirme informações críticas nos canais oficiais da Prefeitura e do Estado. Este app não substitui serviços de saúde ou segurança.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Text("Open source · swift-toolkit · swift-ui-kit")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Versão: \(Bundle.main.versionLabel)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle("Sobre")
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
