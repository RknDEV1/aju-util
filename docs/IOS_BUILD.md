# Build iOS / IPA no GitHub Actions

## Situação atual do repositório

O **Aju Util** hoje é um **Swift Package** (código + telas), não um `.xcodeproj` completo de App Store.

Por isso o workflow padrão faz:

1. **`package-build`** — `swift build` no `macos-14` (compila o código).
2. **`ipa-archive`** — **desligado** até você criar o app Xcode e configurar secrets.

## Job 1 — Package build (já configurado)

Arquivo: `.github/workflows/ios-build.yml`

- Roda em push / PR / manual (`workflow_dispatch`)
- Não instala no iPhone
- Serve para validar que o Swift compila na nuvem

Se o job **cancelar** na hora: cota de minutos macOS ou Actions restrito na conta (já aconteceu em outros repos seus).

## Job 2 — IPA de verdade (quando tiver Mac uma vez)

### Pré-requisitos

1. Em um Mac com Xcode:
   - File → New → App (SwiftUI)
   - Nome sugerido: `AjuUtilApp`
   - Adicionar os pacotes / copiar `Sources/AjuUtil`
   - Root: `HomeView()`
   - Commitar `AjuUtilApp.xcodeproj` neste repo

2. Conta Apple (Developer pago é o caminho estável para Ad Hoc / TestFlight).

3. Secrets no GitHub (Settings → Secrets and variables → Actions):

| Secret | Conteúdo |
|--------|----------|
| `BUILD_CERTIFICATE_BASE64` | `.p12` em base64 |
| `P12_PASSWORD` | Senha do p12 |
| `KEYCHAIN_PASSWORD` | Senha qualquer para keychain do runner |
| `BUILD_PROVISION_PROFILE_BASE64` | `.mobileprovision` em base64 |
| `APPLE_TEAM_ID` | Team ID (10 caracteres) |

4. Variable do repositório:

| Variable | Valor |
|----------|--------|
| `ENABLE_IPA_BUILD` | `true` |

### Gerar base64 (no Mac)

```bash
base64 -i Certificates.p12 | pbcopy
base64 -i profile.mobileprovision | pbcopy
```

### Instalar o IPA no iPhone

Mesmo com artifact no Actions, a instalação depende de:

- Perfil **Ad Hoc** com o UDID do aparelho, ou
- **TestFlight**, ou
- Ferramentas de sideload (com limitações e riscos)

**Sem assinatura Apple válida, o IPA não instala de forma normal.**

## Sem Mac / sem PC

Você consegue:

- Manter o código no GitHub
- Rodar o job de **package build** (se a conta permitir macOS)
- Baixar logs/artefatos pelo celular no site do GitHub

Você **não** consegue, só com o celular, configurar certificados com conforto nem publicar na App Store.

## Resumo

| Objetivo | Viável agora? |
|----------|----------------|
| Compilar o package no Actions | Sim (job 1) |
| Gerar IPA assinada | Só após Xcode project + secrets |
| Usar o app no iPhone no dia a dia | Ainda precisa de assinatura + instalação |
