# Build iOS / IPA

## O que existe agora no repo

| Item | Status |
|------|--------|
| Código SwiftUI (`Sources/AjuUtil`) | Sim |
| `AjuUtilApp.xcodeproj` | Sim (mínimo, gerado para CI/Xcode) |
| `AjuUtilApp/AjuUtilApp.swift` (`@main`) | Sim |
| Assinatura Apple (certs) | **Não** — você precisa configurar |
| Runner macOS na sua conta GitHub | Pode estar bloqueado (*scheduled macOS 14 runner*) |

## Abrir no Xcode (quando tiver Mac)

1. Clone o repo  
2. Abra `AjuUtilApp.xcodeproj`  
3. Selecione o target **AjuUtilApp**  
4. Em Signing: marque seu Team  
5. Rode no simulador ou iPhone  

O app usa o package local `.` (produto `AjuUtil`).

## IPA no GitHub Actions

1. Runner **macOS** precisa funcionar na conta  
2. Secrets de assinatura (ver abaixo)  
3. Variable `ENABLE_IPA_BUILD=true`  
4. Actions → **iOS Build** → Run workflow  

### Secrets

| Secret | Conteúdo |
|--------|----------|
| `BUILD_CERTIFICATE_BASE64` | `.p12` em base64 |
| `P12_PASSWORD` | Senha do p12 |
| `KEYCHAIN_PASSWORD` | Senha do keychain temporário |
| `BUILD_PROVISION_PROFILE_BASE64` | `.mobileprovision` em base64 |
| `APPLE_TEAM_ID` | Team ID |

### Variable

`ENABLE_IPA_BUILD` = `true`

## Sem Mac

O `.xcodeproj` **não gera IPA sozinho** no celular.  
Ainda é necessário macOS (Actions ou máquina) + certificados Apple para IPA instalável.
