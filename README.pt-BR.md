# Aju Util

App **iOS nativo** de utilidade para **Aracaju** e Grande Aracaju.

> English: [README.md](README.md)

## Recursos

- Emergência rápida e **modo emergência**
- Busca, categorias, favoritos e compartilhar
- **Dicas de saúde** (offline, só orientação)
- **Mapa** + **modo offline** com coordenadas e atalho para Apple Maps
- Conteúdo em JSON no aparelho

## Offline vs online

| Recurso | Offline |
|---------|---------|
| Contatos, busca, favoritos | Sim |
| Dicas de saúde | Sim |
| Coordenadas dos pontos | Sim |
| Mapa visual (imagens do mapa) | Pode precisar de rede na 1ª vez |

O MapKit da Apple não permite “baixar Aracaju inteira” como app de navegação offline completo sem soluções pesadas. Por isso o app guarda **coordenadas** e um **modo offline** explícito.

## Stack

SwiftUI · MapKit · [swift-toolkit](https://github.com/RknDEV1/swift-toolkit) · [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Como rodar

App iOS no Xcode + pacotes na branch `main` → root `HomeView()`.

## Licença

MIT
