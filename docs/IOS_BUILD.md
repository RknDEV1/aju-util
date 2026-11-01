# Build iOS / IPA — Aju Util

## O que já está no GitHub

- Código do app (`Sources/AjuUtil`)
- `AjuUtilApp.xcodeproj` + `AjuUtilApp/AjuUtilApp.swift`
- Workflow `.github/workflows/ios-build.yml`

## Dois tipos de build

### 1) Build de simulador (sem certificados)

O job **Build (macOS)** tenta:

1. `swift build`
2. `xcodebuild` para **iOS Simulator** com `CODE_SIGNING_ALLOWED=NO`

Se a sua conta **tiver** runner macOS, isso valida o projeto.

**Não instala no iPhone físico.**

### 2) IPA assinada (no iPhone)

Só roda se:

1. Variable do repo: `ENABLE_IPA_BUILD` = `true`
2. Secrets preenchidos (abaixo)
3. Runner macOS disponível

| Secret | Descrição |
|--------|-----------|
| `BUILD_CERTIFICATE_BASE64` | arquivo `.p12` em base64 |
| `P12_PASSWORD` | senha do p12 |
| `KEYCHAIN_PASSWORD` | senha qualquer |
| `BUILD_PROVISION_PROFILE_BASE64` | `.mobileprovision` em base64 |
| `APPLE_TEAM_ID` | Team ID Apple |

Isso **exige conta Apple** (Developer) e, na prática, **um Mac pelo menos uma vez** para criar cert/profile.

## Erro "scheduled macOS 14 runner"

A GitHub **não está dando** máquina macOS para a conta.

Resolução:

1. https://github.com/settings/billing — minutos / spending limit
2. Settings do repo → Actions → permitir workflows
3. Esperar reset do ciclo ou adicionar crédito

**Nenhum YAML corrige falta de runner macOS.**

## Sem Mac em casa

| Objetivo | Caminho |
|----------|---------|
| Portfólio de código | Já ok no GitHub |
| Compilar na nuvem | Só se macOS Actions liberar |
| IPA no iPhone | Certs Apple + macOS (Actions ou alugado) |
| Usar no celular agora | App web (não IPA) |
