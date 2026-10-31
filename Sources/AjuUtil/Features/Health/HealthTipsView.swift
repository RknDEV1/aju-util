import SwiftUI
import SwiftUIKit

/// Orientational tips only — not medical advice.
struct HealthTipsView: View {
    private let tips: [(title: String, body: String, icon: String)] = [
        (
            "Quando ligar 192 (SAMU)",
            "Dor forte no peito, falta de ar intensa, desmaio, trauma grave, convulsão ou risco imediato à vida. Não use o SAMU como consulta de rotina.",
            "cross.case.fill"
        ),
        (
            "Central 0800 da Saúde",
            "Use a Central de Atendimento da Saúde para orientações e agendamentos em horário comercial. Não substitui emergência.",
            "phone.fill"
        ),
        (
            "Saúde mental",
            "O CVV (188) oferece apoio emocional gratuito 24h. Em crise com risco à vida, combine com SAMU/PM conforme a gravidade.",
            "heart.fill"
        ),
        (
            "Informação oficial",
            "Horários de UBS, filas e plantões mudam. Confirme sempre no site ou telefone oficial da Prefeitura / SMS.",
            "checkmark.shield.fill"
        ),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(
                    "Dicas de saúde",
                    subtitle: "Orientação geral — não substitui atendimento médico"
                )

                ForEach(tips, id: \.title) { tip in
                    CardView {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: tip.icon)
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 28)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(tip.title)
                                    .font(.headline)
                                Text(tip.body)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                Text("Este app não realiza diagnóstico nem agenda consultas automaticamente.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle("Dicas de saúde")
    }
}
