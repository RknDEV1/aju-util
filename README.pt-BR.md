# Aju Util

App **iOS nativo** de utilidade para **Aracaju** e Grande Aracaju — emergências, serviços públicos, cidade e atalhos do ecossistema de tecnologia local.

> English: [README.md](README.md)

## Objetivo

Encontrar contatos e links úteis de forma rápida, com conteúdo curado e uso offline dos dados principais.

## Funcionalidades (MVP)

- Busca
- Categorias: Emergência, Serviços públicos, Saúde, Educação, Cidade, Tech
- Ligar / abrir site
- Favoritos (armazenamento local)
- Conteúdo em JSON (fácil de expandir)

## Stack

- SwiftUI
- [swift-toolkit](https://github.com/RknDEV1/swift-toolkit)
- [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Como rodar no Xcode

1. Crie um **App iOS** (SwiftUI)
2. Adicione os pacotes (branch `main`):
   - `https://github.com/RknDEV1/swift-toolkit.git`
   - `https://github.com/RknDEV1/swift-ui-kit.git`
   - este repositório (ou copie `Sources/AjuUtil`)
3. Use `HomeView()` / `AjuUtilEntry.rootView` como tela inicial
4. Compile no simulador ou no iPhone

Chamadas telefônicas só funcionam no aparelho físico.

## Conteúdo

Os itens ficam em `Sources/AjuUtil/Resources/items.json`.  
Use sempre fontes oficiais. Não invente horários nem orientações legais.

## Licença

MIT
