# Aju Util

App **iOS nativo** de utilidade para **Aracaju** e Grande Aracaju.

> English: [README.md](README.md)

## O que tem hoje

- **Emergência rápida** na home (190, 192, 193, 199)
- Categorias: Emergência, Serviços públicos, Saúde, Educação, Cidade, Tech
- Busca por nome, telefone e tags
- Ligar / abrir site / favoritar / **compartilhar**
- Conteúdo em JSON local (offline)
- Contatos de prefeitura, saúde, Procon, DETRAN-SE, Caju Hub, GDG, Sebrae, CVV, etc.

## Stack

- SwiftUI
- [swift-toolkit](https://github.com/RknDEV1/swift-toolkit)
- [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Como rodar

1. App iOS (SwiftUI) no Xcode  
2. Pacotes: `swift-toolkit`, `swift-ui-kit`, este repo (branch `main`)  
3. Root: `HomeView()` ou `AjuUtilEntry.rootView`  
4. Chamadas telefônicas só no iPhone físico  

## Conteúdo

Edite `Sources/AjuUtil/Resources/items.json`.  
Prefira fontes oficiais. Números e sites podem mudar.

## Licença

MIT
