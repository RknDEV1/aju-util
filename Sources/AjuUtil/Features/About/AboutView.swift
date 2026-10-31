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

                Text("App nativo em SwiftUI. Contatos, dicas de saúde e coordenadas ficam no aparelho para uso offline.")
                    .foregroundStyle(.secondary)

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Offline", systemImage: "wifi.slash")
                            .font(.headline)
                        bullet("Lista de contatos e busca")
                        bullet("Favoritos e dicas de saúde")
                        bullet("Coordenadas dos pontos (modo offline no mapa)")
                        bullet("Mapa visual: pode precisar de internet na 1ª carga (tiles)")
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Aviso importante")
                            .font(.headline)
                        Text("Telefones e sites podem mudar. Em emergência use 190, 192, 193 ou 199. Confirme dados críticos nos canais oficiais. Não é aconselhamento médico.")
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
