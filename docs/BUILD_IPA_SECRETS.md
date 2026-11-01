# Como gerar IPA (estilo antigo / Apple ID)

Workflow: **Build IPA** (`.github/workflows/build-ipa.yml`)

## 1. Secrets no GitHub

Repo **aju-util** → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

| Nome | O que colocar |
|------|----------------|
| `APPLE_ID` | Seu e-mail Apple ID |
| `APPLE_APP_PASSWORD` | [Senha de app](https://appleid.apple.com) → Entrar → Segurança → Senhas de app |
| `APPLE_TEAM_ID` | 10 caracteres em [developer.apple.com](https://developer.apple.com/account) → Membership |

**Não use a senha normal da Apple** — use **senha de app**.

## 2. Team ID no projeto (recomendado)

No Mac, abra o projeto e coloque o Team. Sem Mac, o workflow usa `DEVELOPMENT_TEAM` do secret.

## 3. Rodar

1. Aba **Actions**
2. Workflow **Build IPA**
3. **Run workflow**
4. Se passar: baixe o artifact **AjuUtil-IPA**

## 4. Se cancelar em 2 segundos

Erro *scheduled macOS 14 runner* = a GitHub não deu Mac para a conta.

- [Billing](https://github.com/settings/billing)
- Minutos / spending limit
- Esperar reset ou crédito

## 5. Limites conta free Apple

- App expira (~7 dias)
- Poucos dispositivos
- Não é App Store

## Segurança

Secrets ficam na GitHub. Não poste senha em issue/chat/print.
