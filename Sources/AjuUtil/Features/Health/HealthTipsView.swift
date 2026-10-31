import SwiftUI
import SwiftUIKit

/// Orientational tips only — not medical advice. Fully offline.
struct HealthTipsView: View {
    private let sections: [(title: String, tips: [(title: String, body: String, icon: String)])] = [
        (
            "Emergência",
            [
                (
                    "Quando ligar 192 (SAMU)",
                    "Dor forte no peito, falta de ar intensa, desmaio, trauma grave, convulsão ou risco imediato à vida. Não use o SAMU como consulta de rotina.",
                    "cross.case.fill"
                ),
                (
                    "190, 193 e 199",
                    "190: ocorrência policial. 193: incêndio e salvamento. 199: Defesa Civil (enchentes, deslizamentos e risco coletivo).",
                    "sos.circle.fill"
                ),
            ]
        ),
        (
            "Rede municipal",
            [
                (
                    "Central 0800 da Saúde",
                    "Orientações e agendamentos da rede municipal em horário comercial. Não substitui emergência.",
                    "phone.fill"
                ),
                (
                    "Ouvidoria da Saúde",
                    "Canal para reclamações e solicitações sobre unidades e atendimento do SUS municipal.",
                    "bubble.left.and.bubble.right.fill"
                ),
                (
                    "Hospitais e unidades",
                    "Plantões e especialidades mudam. Confirme sempre por telefone ou site oficial antes de se deslocar.",
                    "building.2.fill"
                ),
            ]
        ),
        (
            "Saúde mental e prevenção",
            [
                (
                    "CVV — 188",
                    "Apoio emocional gratuito 24h. Em crise com risco à vida, use também SAMU/PM conforme a gravidade.",
                    "heart.fill"
                ),
                (
                    "Informação confiável",
                    "Evite diagnósticos por redes sociais. Prefira canais oficiais da Prefeitura e do Ministério da Saúde.",
                    "checkmark.shield.fill"
                ),
            ]
        ),
        (
            "Uso offline deste app",
            [
                (
                    "Sem internet",
                    "Contatos, dicas e favoritos ficam no aparelho. Mapas visuais podem precisar de rede na primeira visualização; coordenadas continuam disponíveis no modo offline.",
                    "wifi.slash"
                ),
            ]
        ),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader(
                    "Dicas de saúde",
                    subtitle: "Conteúdo offline · não substitui atendimento médico"
                )

                ForEach(sections, id: \.title) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(section.title)
                            .font(.title3.weight(.semibold))

                        ForEach(section.tips, id: \.title) { tip in
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
                    }
                }

                Text("Este app não realiza diagnóstico, prescrição ou agendamento automático.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle("Dicas de saúde")
    }
}
