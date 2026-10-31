# Aju Util

App **iOS nativo** de utilidade para **Aracaju** e Grande Aracaju.

> English: [README.md](README.md)

## Recursos

- Emergência rápida e modo emergência
- Busca, favoritos, compartilhar, copiar telefone
- Dicas de saúde (offline)
- Mapa + modo offline com coordenadas
- JSON no aparelho

## CI / build

| Workflow | Função |
|----------|--------|
| `ci.yml` | Valida estrutura (Ubuntu) |
| `ios-build.yml` | Compila o package no macOS; job de IPA opcional (desligado até existir `.xcodeproj` + certificados) |

Guia completo: **[docs/IOS_BUILD.md](docs/IOS_BUILD.md)**.

> Compilar na nuvem **não** instala o app no iPhone sem assinatura Apple.

## Offline

Contatos, dicas e coordenadas funcionam sem rede. O desenho do mapa (tiles) pode precisar de internet na primeira vez.

## Stack

SwiftUI · MapKit · [swift-toolkit](https://github.com/RknDEV1/swift-toolkit) · [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Licença

MIT
